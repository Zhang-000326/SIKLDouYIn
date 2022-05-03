//
//  SILKSplashPageView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKSplashPageView : UIView

@property (nonatomic, assign) CGPoint startPoint;

- (void)loadLabelAnimation;

- (void)moveToPoint:(CGPoint)point;

- (void)setTipsText:(NSString *)text;

- (void)startGuideAnimation;

- (void)addPageViewAnimationWithType:(NSInteger)type;

- (void)guideViewAnimationCancel;

@end

NS_ASSUME_NONNULL_END
