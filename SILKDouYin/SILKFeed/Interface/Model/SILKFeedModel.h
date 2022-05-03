//
//  SILKFeedModel.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import <Foundation/Foundation.h>

@class SILKVideoModel;

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedModel : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) SILKVideoModel *videoModel;

@end

NS_ASSUME_NONNULL_END
