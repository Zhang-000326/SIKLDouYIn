//
//  SILKAVPlayerManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/6.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "SILKAVPlayerManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKAVPlayerManager : SILKService <SILKAVPlayerManager>

@property (nonatomic, strong) NSMutableArray<AVPlayer *>   *playerArray;  //用于存储AVPlayer的数组

+ (void)setAudioMode;

@end

NS_ASSUME_NONNULL_END
