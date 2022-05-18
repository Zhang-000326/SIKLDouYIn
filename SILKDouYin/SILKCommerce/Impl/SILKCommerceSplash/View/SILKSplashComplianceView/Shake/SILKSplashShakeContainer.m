//
//  SILKSplashShakeContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/20.
//

#import "SILKSplashShakeContainer.h"

#import "SILKSplashMotionManager.h"

#import "SILKSplashShakeTipView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashShakeContainer () <CAAnimationDelegate, SILKSplashMotionDelegate>

@end

@implementation SILKSplashShakeContainer

#pragma mark - Lifecycle Method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        self.tipView = [[SILKSplashShakeTipView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        [self addSubview:self.tipView];
        self.tipView.hidden = YES;
        
        [SILKSplashMotionManager sharedInstance].delegate = self;
        [SILKSplashMotionManager sharedInstance].accelerometer = 12 / 9.8f;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tipView.SILK_centerX = self.SILK_centerX;
    self.tipView.SILK_bottom = self.SILK_height - 100.f;

}

#pragma mark - Public Method

- (void)showShakeTipView {
    self.tipView.hidden = NO;
    CAAnimationGroup *animationGroup = [CAAnimationGroup new];
    animationGroup.duration = 1.3;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.fromValue = @(0);
    animation1.toValue = @(1);
    animation1.duration = 0.1;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation2.fromValue = @(self.SILK_height - 140.f);
    animation2.toValue = @(self.SILK_height - 160.f);
    animation2.duration = 0.4;
    animation2.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.2 :1];
    
    animationGroup.animations = @[animation1, animation2];
    animationGroup.delegate = self;
    [animationGroup setValue:@"tipview_animation" forKey:@"id"];
    [self.tipView.layer addAnimation:animationGroup forKey:nil];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *animId = [anim valueForKey:@"id"];
    if (![animId isKindOfClass:[NSString class]]) {
        return;
    }
    
    if ([animId isEqualToString:@"tipview_animation"]) {
        [self.tipView.layer removeAllAnimations];
    }
}

#pragma mark - SILKSplashMotionDelegate

- (void)didReceiveShakeEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveShakeEvent)]) {
        [self.delegate didReceiveShakeEvent];
    }
}

#pragma mark - Getter && Setter


@end
