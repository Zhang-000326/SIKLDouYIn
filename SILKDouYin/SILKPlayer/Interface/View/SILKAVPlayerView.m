//
//  SILKAVPlayer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/6.
//

#import "SILKAVPlayerView.h"
#import "SILKAVPlayerManager.h"

#import "SILKCacheCenter.h"

#import "SILKBaseKit.h"

@interface SILKAVPlayerView ()

@property (nonatomic, strong) NSURL                *sourceURL;              //视频路径
@property (nonatomic, strong) AVPlayerItem         *playerItem;             //视频资源载体
@property (nonatomic, strong) AVPlayerLayer        *playerLayer;            //视频播放器图形化载体
@property (nonatomic, strong) id                   timeObserver;            //视频播放器周期性调用的观察者

@property (nonatomic, strong) NSMutableData        *data;                   //视频缓冲数据
@property (nonatomic, strong) NSMutableArray       *pendingRequests;        //存储AVAssetResourceLoadingRequest的数组

@property (nonatomic, strong) dispatch_queue_t     cancelLoadingQueue;

@property (nonatomic, assign) BOOL                 retried;
@end

@implementation SILKAVPlayerView

//重写initWithFrame
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
//        //初始化存储AVAssetResourceLoadingRequest的数组
//        _pendingRequests = [NSMutableArray array];
        
        //初始化播放器
        self.player = [[AVPlayer alloc] init];
        //添加视频播放器图形化载体AVPlayerLayer
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:self.playerLayer];
        
        //初始化取消视频加载的队列
//        _cancelLoadingQueue = dispatch_queue_create("com.start.cancelloadingqueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //禁止隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _playerLayer.frame = self.layer.bounds;
    [CATransaction commit];
}

//设置播放路径
-(void)setPlayerWithResourceKey:(NSString *)key {
    //播放路径
    NSString *filePath = [[SILKCacheCenter sharedInstance] videoFilePathForKey:key];
    if (SILK_isEmptyString(filePath)) {
        return;
    }
    self.sourceURL = [NSURL fileURLWithPath:filePath];
    self.playerItem = [AVPlayerItem playerItemWithURL:self.sourceURL];

    //观察playerItem.status属性
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    //切换当前AVPlayer播放器的视频源
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    self.playerLayer.player = self.player;
    //给AVPlayerLayer添加周期性调用的观察者，用于更新视频播放进度
    [self addProgressObserver];
    
}

//取消播放
-(void)cancelLoading {
    //暂停视频播放
    [self pause];
    
    //隐藏playerLayer
    [_playerLayer setHidden:YES];
    
    _player = nil;
    [_playerItem removeObserver:self forKeyPath:@"status"];
    _playerItem = nil;
    _playerLayer.player = nil;
    _retried = NO;
    
}



//更新AVPlayer状态，当前播放则暂停，当前暂停则播放
-(void)updatePlayerState {
    if(_player.rate == 0) {
        [self play];
    }else {
        [self pause];
    }
}

//播放
-(void)play {
    [[SILKAVPlayerManager sharedInstance] play:_player];
}

//暂停
-(void)pause {
    [[SILKAVPlayerManager sharedInstance] pause:_player];
}

//重新播放
-(void)replay {
    [[SILKAVPlayerManager sharedInstance] replay:_player];
}

//播放速度
-(CGFloat)rate {
    return [_player rate];
}

//重新请求
-(void)retry {
//    [self cancelLoading];
    [self setPlayerWithResourceKey:_sourceURL.absoluteString];
    _retried = YES;
}

#pragma kvo

// 给AVPlayerLayer添加周期性调用的观察者，用于更新视频播放进度
-(void)addProgressObserver{
    __weak __typeof(self) weakSelf = self;
    //AVPlayer添加周期性回调观察者，一秒调用一次block，用于更新视频播放进度
    _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if(weakSelf.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            //获取当前播放时间
            float current = CMTimeGetSeconds(time);
            //获取视频播放总时间
            float total = CMTimeGetSeconds([weakSelf.playerItem duration]);
            //重新播放视频
            if(total == current) {
                [weakSelf replay];
            }
            //更新视频播放进度方法回调
            if(weakSelf.delegate) {
                [weakSelf.delegate onProgressUpdate:current total:total];
            }
        }
    }];
}

// 响应KVO值变化的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //AVPlayerItem.status
    if([keyPath isEqualToString:@"status"]) {
        if(_playerItem.status == AVPlayerItemStatusFailed) {
            if(!_retried) {
                [self retry];
            }
        }
        //视频源装备完毕，则显示playerLayer
        if(_playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.playerLayer setHidden:NO];
        }
        //视频播放状体更新方法回调
        if(_delegate) {
            [_delegate onPlayItemStatusUpdate:_playerItem.status];
        }
    }else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_player removeTimeObserver:_timeObserver];
}

@end
