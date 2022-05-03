//
//  SILKAVPlayerView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/6.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

//自定义Delegate，用于进度、播放状态更新回调
@protocol SILKAVPlayerUpdateDelegate

@required
//播放进度更新回调方法
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total;

//播放状态更新回调方法
-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status;

@end


@interface SILKAVPlayerView : UIView

@property (nonatomic, strong) AVPlayer *player; ///< 视频播放器

@property(nonatomic, weak) id<SILKAVPlayerUpdateDelegate> delegate; ///< 播放进度、状态更新代理

//设置播放路径
- (void)setPlayerWithResourceKey:(NSString *)key;

//取消加载
- (void)cancelLoading;

//更新AVPlayer状态，当前播放则暂停，当前暂停则播放
- (void)updatePlayerState;

//播放
- (void)play;

//暂停
- (void)pause;

//重新播放
- (void)replay;

//播放速度
- (CGFloat)rate;

//重新请求
- (void)retry;

@end

NS_ASSUME_NONNULL_END
