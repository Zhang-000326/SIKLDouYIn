//
//  SILKUserManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import "SILKService.h"

#import "SILKUserManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKUserManager : SILKService <SILKUserManager>

@property (nonatomic, strong) SILKUserViewController *userViewController;

@end

NS_ASSUME_NONNULL_END
