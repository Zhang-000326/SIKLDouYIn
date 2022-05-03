//
//  SILKSplashDelegate.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/23.
//

#import <Foundation/Foundation.h>

typedef void (^SILKSplashAnimationBlock)(BOOL isNeededAnimation);  ///< 跳转动画

typedef NS_ENUM(NSInteger, SILKSplashComplianceType);

NS_ASSUME_NONNULL_BEGIN

@protocol SILKSplashDelegate <NSObject>

@required

- (void)splashViewShowFinished;

- (void)openWebViewWithAnimationBlock:(nullable SILKSplashAnimationBlock)animationBlock andType:(SILKSplashComplianceType)type;
@end

NS_ASSUME_NONNULL_END
