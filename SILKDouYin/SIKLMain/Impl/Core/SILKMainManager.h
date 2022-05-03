//
//  SILKMainManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import <Foundation/Foundation.h>

#import "SILKMainManagerProtocol.h"

@class SILKMainTabBarController;

NS_ASSUME_NONNULL_BEGIN

@interface SILKMainManager : SILKService <SILKMainManager>

@property (nonatomic, strong) SILKMainTabBarController *mainTabBarController;

+ (instancetype)sharedInstance;

- (NSInteger)currentTabBarItemsNumber;

@end

NS_ASSUME_NONNULL_END
