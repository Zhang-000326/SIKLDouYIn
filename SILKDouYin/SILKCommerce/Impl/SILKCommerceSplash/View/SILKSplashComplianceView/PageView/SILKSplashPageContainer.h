//
//  SILKSplashPageContainer.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SILKSplashPageView;

@interface SILKSplashPageContainer : UIView

@property (nonatomic, strong) SILKSplashPageView *pageView;  ///< 新交互形态翻页样式view

@property (nonatomic, strong) CAGradientLayer *gradintLayer;    ///< 翻页样式右侧阴影


@end

NS_ASSUME_NONNULL_END
