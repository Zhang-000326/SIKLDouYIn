//
//  SILKMainTabBarController.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKMainTabBarController : UITabBarController

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
