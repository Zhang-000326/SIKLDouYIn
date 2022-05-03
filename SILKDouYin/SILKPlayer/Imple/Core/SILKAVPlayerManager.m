//
//  SILKAVPlayerManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/6.
//

#import "SILKAVPlayerManager.h"

#import "SILKBaseKit.h"

@interface SILKAVPlayerManager()

@end

@implementation SILKAVPlayerManager

+ (SILKAVPlayerManager *)sharedInstance {
    static dispatch_once_t once;
    static SILKAVPlayerManager *instance;
    dispatch_once(&once, ^{
        instance = [[SILKAVPlayerManager alloc] init];
    });
    
    return instance;
}

+ (void)setAudioMode {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _playerArray = [NSMutableArray array];
    }
    
    return self;
}
- (void)play:(AVPlayer *)player {
    [_playerArray enumerateObjectsUsingBlock:^(AVPlayer * obj, NSUInteger idx, BOOL *stop) {
        [obj pause];
    }];
    if(![_playerArray containsObject:player]) {
        [_playerArray addObject:player];
    }
    [player play];
}

- (void)pause:(AVPlayer *)player {
    if ([_playerArray containsObject:player]) {
        [player pause];
    }
}

- (void)pauseAll {
    [_playerArray enumerateObjectsUsingBlock:^(AVPlayer * obj, NSUInteger idx, BOOL *stop) {
        [obj pause];
    }];
}

- (void)replay:(AVPlayer *)player {
    [_playerArray enumerateObjectsUsingBlock:^(AVPlayer * obj, NSUInteger idx, BOOL *stop) {
        [obj pause];
    }];
    if ([_playerArray containsObject:player]) {
        [player seekToTime:kCMTimeZero];
        [self play:player];
    } else {
        [_playerArray addObject:player];
        [self play:player];
    }
}

- (void)removeAllPlayers {
    [_playerArray removeAllObjects];
}
@end
