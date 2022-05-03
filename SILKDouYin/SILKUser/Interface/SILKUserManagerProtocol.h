//
//  SILKUserManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import <Foundation/Foundation.h>
#import "SILKServiceCenter.h"

@class SILKUserViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol SILKUserManager <SILKUniqueService>

@property (nonatomic, strong) SILKUserViewController *userViewController;

- (void)loadLoginViewController;

@end

NS_ASSUME_NONNULL_END
