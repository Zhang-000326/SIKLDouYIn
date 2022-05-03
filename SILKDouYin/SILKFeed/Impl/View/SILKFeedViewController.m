//
//  SILKFeedViewController.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import "SILKFeedViewController.h"

#import "SILKAVPlayerManager.h"

// define
#import "SILKMainDefine.h"

// model
#import "SILKFeedModel.h"

// view
#import "SILKFeedTableCell.h"
#import "SILKAVPlayerView.h"

// commerce
#import "SILKCommerceManagerProtocol.h"

NSString * const kSILKFeedTableCell = @"kSILKFeedTableCell";

@interface SILKFeedViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isCurPlayerPause;

@property (nonatomic, copy) NSArray *models;

@end

@implementation SILKFeedViewController


- (instancetype)initWithFeedModels:(NSArray *)models {
    self = [super init];
    if(self) {
        _isCurPlayerPause = NO;
        _currentIndex = 0;
        
        _models = models.copy;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTouchBegin) name:@"StatusBarTouchBeginNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundImage:@"feed_video_loading"];
    [self setUpView];
    
    [GET_INSTANCE_FROM_PROTOCOL(SILKCommerceManager) displaySplashFor:SILKSplashComplianceTypeButton];
}

- (void)setBackgroundImage:(NSString *)imageName {
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.clipsToBounds = YES;
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = [UIImage imageNamed:imageName];
    [self.view addSubview:background];
}

- (void)setUpView {
    self.view.layer.masksToBounds = YES;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_CHILD_CONTROLLER_HEIGHT);
    self.feedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -TABBAR_CHILD_CONTROLLER_HEIGHT, SCREEN_WIDTH, TABBAR_CHILD_CONTROLLER_HEIGHT * 3)];
    self.feedTableView.contentInset = UIEdgeInsetsMake(TABBAR_CHILD_CONTROLLER_HEIGHT, 0, TABBAR_CHILD_CONTROLLER_HEIGHT * 1, 0);
    
    self.feedTableView.backgroundColor = [UIColor clearColor];
    self.feedTableView.rowHeight = TABBAR_CHILD_CONTROLLER_HEIGHT;
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    self.feedTableView.showsVerticalScrollIndicator = NO;
    self.feedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.feedTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.feedTableView registerClass:[SILKFeedTableCell class] forCellReuseIdentifier:kSILKFeedTableCell];
    [self.view addSubview:self.feedTableView];
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_feedTableView.layer removeAllAnimations];
    [[SILKAVPlayerManager sharedInstance] removeAllPlayers];
    
    if ([self hasKey:@"currentIndex"]) {
        [self removeObserver:self forKeyPath:@"currentIndex"];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return TABBAR_CHILD_CONTROLLER_HEIGHT;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //填充视频数据
    SILKFeedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kSILKFeedTableCell forIndexPath:indexPath];
    [cell loadFeedModel:[self.models SILK_objectAtIndex:indexPath.row]];
    [cell loadVideoResource];
    return cell;
}

#pragma ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
        //UITableView禁止响应其他滑动手势
        scrollView.panGestureRecognizer.enabled = NO;
    
        if (translatedPoint.y < -50 && self.currentIndex < (self.models.count - 1)) {
            self.currentIndex++;   //向下滑动索引递增
        }
        if (translatedPoint.y > 50 && self.currentIndex > 0) {
            self.currentIndex--;   //向上滑动索引递减
        }
        
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                                //UITableView滑动到指定cell
                                [self.feedTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                            }
                         completion:^(BOOL finished) {
                                //UITableView可以响应其他滑动手势
                                scrollView.panGestureRecognizer.enabled = YES;
                            }];
        
        
    });
}

#pragma KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //观察currentIndex变化
    if ([keyPath isEqualToString:@"currentIndex"]) {
        //设置用于标记当前视频是否播放的BOOL值为NO
        _isCurPlayerPause = NO;
        //获取当前显示的cell
        SILKFeedTableCell *cell = [self.feedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
        __weak typeof (cell) wcell = cell;
        __weak typeof (self) wself = self;
        //判断当前cell的视频源是否已经准备播放
        if(cell.isPlayerReady) {
            //播放视频
            [cell replay];
        }else {
            [[SILKAVPlayerManager sharedInstance] pauseAll];
            //当前cell的视频源还未准备好播放，则实现cell的OnPlayerReady Block 用于等待视频准备好后通知播放
            cell.onPlayerReady = ^{
                NSIndexPath *indexPath = [wself.feedTableView indexPathForCell:wcell];
                if(!wself.isCurPlayerPause && indexPath && indexPath.row == wself.currentIndex) {
                    [wcell play];
                }
            };
        }
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)statusBarTouchBegin {
    _currentIndex = 0;
}

- (void)applicationBecomeActive {
    SILKFeedTableCell *cell = [self.feedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    if(!_isCurPlayerPause) {
        [cell.playerView play];
    }
}

- (void)applicationEnterBackground {
    SILKFeedTableCell *cell = [self.feedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    _isCurPlayerPause = ![cell.playerView rate];
    [cell.playerView pause];
}

- (BOOL)hasKey:(NSString *)kvoKey {
    BOOL hasKey = NO;
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    for (id keypath in arr) {
        // 存在kvo 的key
        if ([keypath isEqualToString:kvoKey]) {
            hasKey = YES;
            break;
        }
    }
    return hasKey;
}

@end
