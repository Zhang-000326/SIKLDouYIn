//
//  SILKSplashSlideUpContainer.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import <UIKit/UIKit.h>

@class SILKSplashSlideUpView;
@class SILKSplashSlideUpButton;

NS_ASSUME_NONNULL_BEGIN

@interface SILKSplashSlideUpContainer : UIView

@property (nonatomic, strong) SILKSplashSlideUpButton *buttonView;

@property (nonatomic, strong) SILKSplashSlideUpView *slideView;

@end

NS_ASSUME_NONNULL_END
