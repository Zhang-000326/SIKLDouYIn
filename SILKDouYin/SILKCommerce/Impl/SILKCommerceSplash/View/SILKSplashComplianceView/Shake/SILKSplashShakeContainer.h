//
//  SILKSplashShakeContainer.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/20.
//

#import <UIKit/UIKit.h>

@protocol SILKSplashMotionDelegate;

@class SILKSplashShakeTipView;

NS_ASSUME_NONNULL_BEGIN

@interface SILKSplashShakeContainer : UIView

@property (nonatomic, strong) SILKSplashShakeTipView *tipView;           ///< 摇一摇提示文案

@property (nonatomic, weak) id <SILKSplashMotionDelegate> delegate;

- (void)showShakeTipView;

@end

NS_ASSUME_NONNULL_END
