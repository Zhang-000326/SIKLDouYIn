//
//  SILKSplashView+Gesture.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashView+Gesture.h"
#import "SILKSplashSlideUpContainer.h"
#import "SILKSplashSlideSideContainer.h"
#import "SILKSplashPageContainer.h"
#import "SILKSplashPageView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashView ()

@property (nonatomic, assign) SILKSplashComplianceType complianceType;
@property (nonatomic, strong) SILKSplashSlideSideContainer *slideSideContainer;

@property (nonatomic, strong) SILKSplashPageContainer *pageContainer;

@property (nonatomic, assign) BOOL pageViewIsOver;
@property (nonatomic, assign) BOOL pageViewIsShowing;
@property (nonatomic, assign) BOOL jumpAnimationIsShowing;  ///< 跳转动画正在执行中，避免开屏页因为展示时间而直接退出

@end

@implementation SILKSplashView (Gesture)

- (void)onButtonTapGesture:(SILKBaseTapGestureRecognizer *)gesture {
    
}

- (void)onSlidePanGesture:(SILKBasePanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        // 滑动距离超过指定值，不考虑速度问题
        CGFloat deltaX = gesture.beganPoint.x - gesture.endPoint.x;
        CGFloat deltaY = gesture.beganPoint.y - gesture.endPoint.y;
        CGFloat distance = deltaX * deltaX + deltaY * deltaY;
        CGFloat slideDistance = 120 * 120;
        
        // 判断是否触发滑动事件
        BOOL enableSlide = (distance >= slideDistance);
        if (enableSlide) {
            if (self.complianceType == SILKSplashComplianceTypeSlideUp) {
                enableSlide = (deltaY > 0);
            } else if (self.complianceType == SILKSplashComplianceTypeSlideSide) {
                enableSlide = (deltaX > 0);
            }
        }
        
        if (enableSlide) {
            // 以动画的方式关闭开屏（具体的事件处理逻辑放在：BDASplashView+Helper 中）
            [self splashViewShouldJump];
        }
    }
}

- (void)onPagePanGesture:(SILKBasePanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan && !self.pageViewIsShowing) {
        if (!self.pageViewIsShowing) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(onSplashViewSlideCancel) object:nil];
            self.pageViewIsShowing = YES;
            self.pageContainer.pageView.startPoint = gesture.beganPoint;
            [self.pageContainer.pageView guideViewAnimationCancel];
        }
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (self.pageViewIsShowing) {
            [self.pageContainer.pageView moveToPoint:gesture.endPoint];
        }
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.pageViewIsShowing) {
            self.pageViewIsShowing = NO;
            [self.pageContainer.pageView moveToPoint:gesture.endPoint];
            // 滑动距离超过指定值，不考虑速度问题
            CGFloat deltaX = gesture.beganPoint.x - gesture.endPoint.x;
            CGFloat deltaY = gesture.beganPoint.y - gesture.endPoint.y;
            CGFloat distance = deltaX * deltaX + deltaY * deltaY;
            CGFloat slideDistance = 120 * 120;

            // 判断是否触发滑动事件
            BOOL enableSlide = (distance >= slideDistance) && (deltaX > 0);
            if (enableSlide) {
                [self.pageContainer.pageView addPageViewAnimationWithType:1];
                [self performSelector:@selector(splashViewShouldJump) withObject:nil afterDelay:0.4f];
            } else {
                [self.pageContainer.pageView addPageViewAnimationWithType:0];
                [self performSelector:@selector(onSplashViewSlideCancel) withObject:nil afterDelay:0.4f];
            }
        }
    }
}

- (void)onSplashViewSlideCancel {
    self.pageViewIsShowing = NO;
    if (self.pageViewIsOver) {
        [self splashCompletedWithAnimation:YES];
    }
}

- (void)splashViewShouldJump {
    if (self.jumpAnimationIsShowing) {
        return;
    }
    self.jumpAnimationIsShowing = YES;
    
    switch (self.complianceType) {
        case SILKSplashComplianceTypeSlideUp: {
            [self splashClickedWithAnimationBlock:^(BOOL isNeededAnimation) {
                if (isNeededAnimation) {
                    [UIView animateWithDuration:0.4f animations:^{
                        // 移除整个开屏
                        self.SILK_bottom = 0;
                    } completion:^(BOOL finished) {
                        [self splashCompletedWithAnimation:NO];
                    }];
                } else {
                    [self splashCompletedWithAnimation:YES];
                }
            } andType:SILKSplashComplianceTypeSlideUp];
        } break;
        case SILKSplashComplianceTypeSlideSide: {
            [self splashClickedWithAnimationBlock:^(BOOL isNeededAnimation) {
                if (isNeededAnimation) {
                    [UIView animateWithDuration:0.4f animations:^{
                        // 移除整个开屏
                        self.SILK_right = 0;
                    } completion:^(BOOL finished) {
                        [self splashCompletedWithAnimation:NO];
                    }];
                } else {
                    [self splashCompletedWithAnimation:YES];
                }
            } andType:SILKSplashComplianceTypeSlideSide];
        } break;
        case SILKSplashComplianceTypePage:
            [self splashClickedWithAnimationBlock:nil andType:SILKSplashComplianceTypePage];
            break;
        default:
            [self splashClickedWithAnimationBlock:nil andType:SILKSplashComplianceTypeNone];
            break;
    }
    
   
}

@end
