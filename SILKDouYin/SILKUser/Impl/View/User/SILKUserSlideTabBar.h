//
//  SILKUserSlideTabBar.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SILKUserSlideTabBarDelegate

@required

- (void)tabBarTapAction:(NSInteger)index;

@end

@interface SILKUserSlideTabBar : UIView

@property (nonatomic, weak) id <SILKUserSlideTabBarDelegate> delegate;

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
