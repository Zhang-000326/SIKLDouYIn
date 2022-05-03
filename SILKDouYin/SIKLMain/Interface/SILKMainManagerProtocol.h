//
//  SILKMainManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import <Foundation/Foundation.h>

#import "SILKServiceCenter.h"

NS_ASSUME_NONNULL_BEGIN

@class SILKMainTabBarController;

@protocol SILKMainManager <SILKUniqueService>

@property (nonatomic, strong) SILKMainTabBarController *mainTabBarController;

@end

NS_ASSUME_NONNULL_END
