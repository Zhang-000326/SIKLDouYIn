//
//  SILKFeedTableCell.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import "SILKFeedTableCell.h"

// define
#import "SILKFeedDefine.h"
#import "SILKMainDefine.h"

// model
#import "SILKFeedModel.h"
#import "SILKVideoModel.h"

// view
#import "SILKAVPlayerView.h"
#import "SILKFeedMusicNameLabel.h"
#import "SILKFeedMusicCDView.h"
#import "SILKFeedLoveView.h"
#import "SILKFeedFocusView.h"
#import "SILKFeedSharePopView.h"

static const NSInteger kFeedLikeCommentTag = 0x01;
static const NSInteger kFeedLikeShareTag   = 0x02;

@interface SILKFeedTableCell () <SILKAVPlayerUpdateDelegate>

@property (nonatomic, strong) UIView                   *container;
@property (nonatomic ,strong) CAGradientLayer          *gradientLayer;
@property (nonatomic ,strong) UIImageView              *pauseIcon;
@property (nonatomic, strong) UIView                   *playerStatusBar;
@property (nonatomic ,strong) UIImageView              *musicIcon;
@property (nonatomic, strong) UITapGestureRecognizer   *singleTapGesture;
@property (nonatomic, assign) NSTimeInterval           lastTapTime;
@property (nonatomic, assign) CGPoint                  lastTapPoint;

@end

@implementation SILKFeedTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.01];
        self.lastTapTime = 0;
        self.lastTapPoint = CGPointZero;
        [self initSubViews];
    }
    return self;
}




- (void)initSubViews {
    //init player view;
    self.playerView = [[SILKAVPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_CHILD_CONTROLLER_HEIGHT)];
    self.playerView.delegate = self;
    [self.contentView addSubview:self.playerView];
    [self.playerView setPlayerWithResourceKey:self.feedModel.videoModel.key];
    
    //init hover on player view container
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_CHILD_CONTROLLER_HEIGHT)];
    [self.contentView addSubview:self.container];
    
    self.singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.container addGestureRecognizer:self.singleTapGesture];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor];
    self.gradientLayer.locations = @[@0.3, @0.6, @1.0];
    self.gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    self.gradientLayer.endPoint = CGPointMake(0.0f, 1.0f);
    [self.container.layer addSublayer:self.gradientLayer];
    
    self.pauseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.pauseIcon.image = [UIImage imageNamed:@"feed_play_pause"];
    self.pauseIcon.contentMode = UIViewContentModeCenter;
    self.pauseIcon.layer.zPosition = 3;
    self.pauseIcon.hidden = NO;
    [self.container addSubview:self.pauseIcon];
    
    //init player status bar
    self.playerStatusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0.5)];
    self.playerStatusBar.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [self.playerStatusBar setHidden:YES];
    [self.container addSubview:self.playerStatusBar];
    
    //init aweme message
    self.musicIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    self.musicIcon.contentMode = UIViewContentModeCenter;
    self.musicIcon.image = [UIImage imageNamed:@"feed_music_note_3"];
    [self.container addSubview:self.musicIcon];
    
    self.musicNameLabel = [[SILKFeedMusicNameLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 24)];
    self.musicNameLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.musicNameLabel.font = [UIFont systemFontOfSize:14];
    [self.container addSubview:self.musicNameLabel];
    
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.numberOfLines = 0;
    self.descLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    [self.container addSubview:self.descLabel];
    
    
    self.authorNameLabel = [[UILabel alloc] init];
    self.authorNameLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.authorNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.container addSubview:self.authorNameLabel];
    
    
    //init music alum view
    self.musicCD = [[SILKFeedMusicCDView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.container addSubview:_musicCD];
    
    //init share、comment、like action view
    self.shareView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
    self.shareView.contentMode = UIViewContentModeCenter;
    self.shareView.image = [UIImage imageNamed:@"feed_share"];
    self.shareView.userInteractionEnabled = YES;
    self.shareView.tag = kFeedLikeShareTag;
    [self.shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [self.container addSubview:self.shareView];
    
    self.shareNum = [[UILabel alloc] init];
    self.shareNum.text = @"0";
    self.shareNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.shareNum.font = [UIFont systemFontOfSize:12.0];
    [self.container addSubview:self.shareNum];
    
    self.commentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
    self.commentView.contentMode = UIViewContentModeCenter;
    self.commentView.image = [UIImage imageNamed:@"feed_comment"];
    self.commentView.userInteractionEnabled = YES;
    self.commentView.tag = kFeedLikeCommentTag;
    [self.commentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [self.container addSubview:self.commentView];
    
    self.commentNum = [[UILabel alloc] init];
    self.commentNum.text = @"0";
    self.commentNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.commentNum.font = [UIFont systemFontOfSize:12.0];
    [self.container addSubview:self.commentNum];
    
    self.loveView = [SILKFeedLoveView new];
    [self.container addSubview:self.loveView];
    
    self.loveNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
    self.loveNum.text = @"0";
    self.loveNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.loveNum.font = [UIFont systemFontOfSize:12.0];
    [self.container addSubview:self.loveNum];
    
    //init avatar
    CGFloat avatarRadius = 25;
    self.authorAvatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, avatarRadius * 2, avatarRadius * 2)];
    self.authorAvatarView.image = [UIImage imageNamed:@"feed_default_author_avatar"];
    self.authorAvatarView.layer.cornerRadius = 25;
    self.authorAvatarView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    self.authorAvatarView.layer.borderWidth = 1;
    [self.container addSubview:self.authorAvatarView];
    
    //init focus action
    self.focusView = [[SILKFeedFocusView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [self.container addSubview:self.focusView];
   
  
   
    self.pauseIcon.center = self.center;
    
    //make constraintes
    self.playerStatusBar.SILK_centerX = self.container.SILK_centerX;
    self.playerStatusBar.SILK_bottom = self.container.SILK_bottom - 2;
    
    self.musicIcon.SILK_left = self.container.SILK_left;
    self.musicIcon.SILK_bottom = self.container.SILK_bottom - 30;

    self.musicNameLabel.SILK_left = self.musicIcon.SILK_right;
    self.musicNameLabel.SILK_centerY = self.musicIcon.SILK_centerY;
    
    [self.descLabel sizeToFit];
    if (self.descLabel.SILK_width >= SCREEN_WIDTH * 3 / 5) {
        self.descLabel.SILK_width = SCREEN_WIDTH * 3 / 5;
    }
    self.descLabel.SILK_left = self.container.SILK_left + 10;
    self.descLabel.SILK_bottom = self.musicIcon.SILK_top;
    
    [self.authorNameLabel sizeToFit];
    if (self.authorNameLabel.SILK_width >= (SCREEN_WIDTH * 3 / 4 + 30)) {
        self.authorNameLabel.SILK_width = (SCREEN_WIDTH * 3 / 4 + 30);
    }
    self.authorNameLabel.SILK_left = self.container.SILK_left + 10;
    self.authorNameLabel.SILK_bottom = self.descLabel.SILK_top + 5;
    
    self.musicCD.SILK_right = self.container.SILK_right - 10;
    self.musicCD.SILK_bottom = self.musicNameLabel.SILK_bottom;
    
    self.shareView.SILK_right =  self.container.SILK_right - 10;
    self.shareView.SILK_bottom = self.musicCD.SILK_top - 50;

    [self.shareNum sizeToFit];
    self.shareNum.SILK_centerX = self.shareView.SILK_centerX;
    self.shareNum.SILK_top = self.shareView.SILK_bottom;

    self.commentView.SILK_right =  self.container.SILK_right - 10;
    self.commentView.SILK_bottom = self.shareView.SILK_top - 25;

    [self.commentNum sizeToFit];
    self.commentNum.SILK_centerX = self.commentView.SILK_centerX;
    self.commentNum.SILK_top = self.commentView.SILK_bottom;
    
    self.loveView.SILK_right =  self.container.SILK_right - 10;
    self.loveView.SILK_bottom = self.commentView.SILK_top - 25;
    
    [self.loveNum sizeToFit];
    self.loveNum.SILK_centerX = self.loveView.SILK_centerX;
    self.loveNum.SILK_top = self.loveView.SILK_bottom;
    
    self.authorAvatarView.SILK_right =  self.container.SILK_right - 10;
    self.authorAvatarView.SILK_bottom = self.loveView.SILK_top - 35;
    
    self.focusView.SILK_centerX =  self.authorAvatarView.SILK_centerX;
    self.focusView.SILK_centerY = self.authorAvatarView.SILK_bottom;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.isPlayerReady = NO;
    [self.playerView cancelLoading];
    [self.pauseIcon setHidden:YES];
    
    [self.authorAvatarView setImage:[UIImage imageNamed:@"feed_default_author_avatar"]];
    
    [self.musicCD resetView];
    [self.loveView resetView];
    [self.focusView resetView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.gradientLayer.frame = CGRectMake(0, self.frame.size.height - 500, self.frame.size.width, 500);
    [CATransaction commit];
    
    
    
    self.pauseIcon.center = self.center;
    
    //make constraintes
    self.playerStatusBar.SILK_centerX = self.container.SILK_centerX;
    self.playerStatusBar.SILK_bottom = self.container.SILK_bottom - 2;
    
    self.musicIcon.SILK_left = self.container.SILK_left;
    self.musicIcon.SILK_bottom = self.container.SILK_bottom - 20;

    self.musicNameLabel.SILK_left = self.musicIcon.SILK_right;
    self.musicNameLabel.SILK_centerY = self.musicIcon.SILK_centerY;
    
    [self.descLabel sizeToFit];
    if (self.descLabel.SILK_width >= SCREEN_WIDTH * 3 / 5) {
        self.descLabel.SILK_width = SCREEN_WIDTH * 3 / 5;
    }
    self.descLabel.SILK_left = self.container.SILK_left + 10;
    self.descLabel.SILK_bottom = self.musicIcon.SILK_top - 10;
    
    [self.authorNameLabel sizeToFit];
    if (self.authorNameLabel.SILK_width >= (SCREEN_WIDTH * 3 / 4 + 30)) {
        self.authorNameLabel.SILK_width = (SCREEN_WIDTH * 3 / 4 + 30);
    }
    self.authorNameLabel.SILK_left = self.container.SILK_left + 10;
    self.authorNameLabel.SILK_bottom = self.descLabel.SILK_top - 5;
    
    self.musicCD.SILK_right = self.container.SILK_right - 10;
    self.musicCD.SILK_bottom = self.musicNameLabel.SILK_bottom;
    
    self.shareView.SILK_right =  self.container.SILK_right - 10;
    self.shareView.SILK_bottom = self.musicCD.SILK_top - 50;

    [self.shareNum sizeToFit];
    self.shareNum.SILK_centerX = self.shareView.SILK_centerX;
    self.shareNum.SILK_top = self.shareView.SILK_bottom;

    self.commentView.SILK_right =  self.container.SILK_right - 10;
    self.commentView.SILK_bottom = self.shareView.SILK_top - 25;

    [self.commentNum sizeToFit];
    self.commentNum.SILK_centerX = self.commentView.SILK_centerX;
    self.commentNum.SILK_top = self.commentView.SILK_bottom;
    
    self.loveView.SILK_right =  self.container.SILK_right - 10;
    self.loveView.SILK_bottom = self.commentView.SILK_top - 25;
    
    [self.loveNum sizeToFit];
    self.loveNum.SILK_centerX = self.loveView.SILK_centerX;
    self.loveNum.SILK_top = self.loveView.SILK_bottom;
    
    self.authorAvatarView.SILK_right =  self.container.SILK_right - 10;
    self.authorAvatarView.SILK_bottom = self.loveView.SILK_top - 35;
    
    self.focusView.SILK_centerX =  self.authorAvatarView.SILK_centerX;
    self.focusView.SILK_centerY = self.authorAvatarView.SILK_bottom;
    
    
}




//gesture
- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kFeedLikeCommentTag: {
            break;
        }
        case kFeedLikeShareTag: {
            SILKFeedSharePopView *popView = [[SILKFeedSharePopView alloc] init];
            [popView show];
            break;
        }
        default: {
            //获取点击坐标，用于设置爱心显示位置
            CGPoint point = [sender locationInView:self.container];
            //获取当前时间
            NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
            //判断当前点击时间与上次点击时间的时间间隔
            if(time - self.lastTapTime > 0.25f) {
                //推迟0.25秒执行单击方法
                [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
            }else {
                //取消执行单击方法
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
                //执行连击显示爱心的方法
                [self showLikeViewAnim:point oldPoint:self.lastTapPoint];
            }
            //更新上一次点击位置
            self.lastTapPoint = point;
            //更新上一次点击时间
            self.lastTapTime =  time;
            break;
        }
    }
    
}

- (void)singleTapAction {
    [self showPauseViewAnim:[self.playerView rate]];
    [self.playerView updatePlayerState];
}

//暂停播放动画
- (void)showPauseViewAnim:(CGFloat)rate {
    if(rate == 0) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.pauseIcon.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self.pauseIcon setHidden:YES];
                         }];
    }else {
        [self.pauseIcon setHidden:NO];
        self.pauseIcon.transform = CGAffineTransformMakeScale(1.8f, 1.8f);
        self.pauseIcon.alpha = 1.0f;
        [UIView animateWithDuration:0.25f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                self.pauseIcon.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                            } completion:^(BOOL finished) {
                            }];
    }
}

//连击爱心动画
- (void)showLikeViewAnim:(CGPoint)newPoint oldPoint:(CGPoint)oldPoint {
    UIImageView *likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feed_love_after_click"]];
    CGFloat k = ((oldPoint.y - newPoint.y)/(oldPoint.x - newPoint.x));
    k = fabs(k) < 0.5 ? k : (k > 0 ? 0.5f : -0.5f);
    CGFloat angle = M_PI_4 * -k;
    likeImageView.frame = CGRectMake(newPoint.x, newPoint.y, 80, 80);
    likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 0.8f, 1.8f);
    [self.container addSubview:likeImageView];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 1.0f, 1.0f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5f
                                               delay:0.5f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 3.0f, 3.0f);
                                              likeImageView.alpha = 0.0f;
                                          }
                                          completion:^(BOOL finished) {
                                              [likeImageView removeFromSuperview];
                                          }];
                     }];
}

//加载动画
-(void)startLoadingPlayItemAnim:(BOOL)isStart {
    if (isStart) {
        _playerStatusBar.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        [self.playerStatusBar setHidden:NO];
        [self.playerStatusBar.layer removeAllAnimations];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
        animationGroup.duration = 0.5;
        animationGroup.beginTime = CACurrentMediaTime() + 0.5;
        animationGroup.repeatCount = MAXFLOAT;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animation];
        scaleAnimation.keyPath = @"transform.scale.x";
        scaleAnimation.fromValue = @(1.0f);
        scaleAnimation.toValue = @(1.0f * SCREEN_WIDTH);
        
        CABasicAnimation * alphaAnimation = [CABasicAnimation animation];
        alphaAnimation.keyPath = @"opacity";
        alphaAnimation.fromValue = @(1.0f);
        alphaAnimation.toValue = @(0.5f);
        [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
        [self.playerStatusBar.layer addAnimation:animationGroup forKey:nil];
    } else {
        [self.playerStatusBar.layer removeAllAnimations];
        [self.playerStatusBar setHidden:YES];
    }
    
}

// SILKAVPlayerUpdateDelegate
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total {
    //播放进度更新
}

-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status {
    switch (status) {
        case AVPlayerItemStatusUnknown:
            [self startLoadingPlayItemAnim:YES];
            break;
        case AVPlayerItemStatusReadyToPlay:
            [self startLoadingPlayItemAnim:NO];
            
            self.isPlayerReady = YES;
            [self.musicCD startAnimation:[self.playerView rate]]; // video.rate
            
            if(_onPlayerReady) {
                self.onPlayerReady();
            }
            break;
        case AVPlayerItemStatusFailed:
            [self startLoadingPlayItemAnim:NO];
            break;
        default:
            break;
    }
}

// update method
- (void)loadFeedModel:(SILKFeedModel *)feedModel {
    self.feedModel = feedModel;
    
    [self.authorNameLabel setText:@"@张骞"];
    [self.descLabel setText:@"毕业设计-2018091609007"];
    [self.musicNameLabel setText:@"%音乐 - %作者"];
    [self.loveNum setText:@"666"];
    [self.commentNum setText:@"0"];
    [self.shareNum setText:@"255"];
}

- (void)loadVideoResource {
    [self.playerView setPlayerWithResourceKey:self.feedModel.videoModel.key];
    
}

- (void)play {
    [self.playerView play];
    [self.pauseIcon setHidden:YES];
}

- (void)pause {
    [self.playerView pause];
    [self.pauseIcon setHidden:NO];
}

- (void)replay {
    [self.playerView replay];
    [self.pauseIcon setHidden:YES];
}

@end
