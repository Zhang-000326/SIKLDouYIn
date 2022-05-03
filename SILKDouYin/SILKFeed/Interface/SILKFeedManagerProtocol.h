//
//  SILKFeedManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import <Foundation/Foundation.h>

#import "SILKServiceCenter.h"

NS_ASSUME_NONNULL_BEGIN

@class SILKFeedViewController;

@protocol SILKFeedManager <SILKUniqueService>

@required

@property (nonatomic, strong, readonly) SILKFeedViewController *feedVC;

@property (nonatomic, copy) NSArray *feedModelArray;

@property (nonatomic, copy) NSArray *feedVideoKeyArray;

- (void)saveVideoData:(NSData *)videoData;

@end

NS_ASSUME_NONNULL_END
