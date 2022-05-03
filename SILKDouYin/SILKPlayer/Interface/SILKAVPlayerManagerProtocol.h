//
//  SILKAVPlayerManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/5/1.
//

#import <Foundation/Foundation.h>

#import "SILKServiceCenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SILKAVPlayerManager <SILKUniqueService>

@required

@property (nonatomic, strong) NSMutableArray<AVPlayer *> *playerArray; ///< 用于存储AVPlayer的数组

/**
 * 使视频播放器开始播放
 *
 * @param player 视频播放器
 */
- (void)play:(AVPlayer *)player;

/**
 * 使视频播放器暂停播放
 *
 * @param player 视频播放器
 */
- (void)pause:(AVPlayer *)player;

/**
 * 暂停所有视频播放器
 *
 */
- (void)pauseAll;

/**
 * 使视频播放器重新播放
 *
 * @param player 视频播放器
 */
- (void)replay:(AVPlayer *)player;

/**
 * 移除所有视频播放器
 *
 */
- (void)removeAllPlayers;

@end

NS_ASSUME_NONNULL_END
