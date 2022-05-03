//
//  SILKCommerceManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/9.
//

#import <Foundation/Foundation.h>
#import "SILKServiceCenter.h"

#import "SILKCommerceDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SILKCommerceManager <SILKUniqueService>

- (void)displaySplashFor:(SILKSplashComplianceType)type;

@end

NS_ASSUME_NONNULL_END
