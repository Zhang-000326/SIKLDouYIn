//
//  SILKFeedManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import <Foundation/Foundation.h>

#import "SILKFeedManagerProtocol.h"

@class SILKFeedViewController;
@class SILKVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedManager : SILKService <SILKFeedManager>

@property (nonatomic, strong, readonly) SILKFeedViewController *feedVC;

@property (nonatomic, copy) NSArray *feedModelArray;

@property (nonatomic, copy) NSArray *feedVideoKeyArray;

@end

NS_ASSUME_NONNULL_END
