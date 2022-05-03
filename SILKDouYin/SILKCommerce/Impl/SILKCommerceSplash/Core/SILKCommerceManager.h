//
//  SILKCommerceManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/7.
//

#import <UIKit/UIKit.h>

#import "SILKCommerceManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKCommerceManager : SILKService <SILKCommerceManager>

+ (instancetype)sharedInstance;

- (void)displaySplashFor:(SILKSplashComplianceType)type;

@end

NS_ASSUME_NONNULL_END
