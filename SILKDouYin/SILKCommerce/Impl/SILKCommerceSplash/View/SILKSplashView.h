//
//  SILKSplashView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SILKSplashComplianceType);

typedef void (^SILKSplashAnimationBlock)(BOOL isNeededAnimation);  ///< 跳转动画

@protocol SILKSplashDelegate;

@interface SILKSplashView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               complianceType:(SILKSplashComplianceType)type
                     delegate:(id<SILKSplashDelegate>)delegate;

- (void)splashClickedWithAnimationBlock:(nullable SILKSplashAnimationBlock)animationBlock andType:(SILKSplashComplianceType)type;

- (void)splashCompletedWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
