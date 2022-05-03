//
//  SILKSplashSlideUpContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashSlideUpContainer.h"

#import "SILKSplashSlideUpView.h"
#import "SILKSplashSlideUpButton.h"

#import "SILKCommerceDefine.h"

@implementation SILKSplashSlideUpContainer

- (void)layoutSubviews {
    [super layoutSubviews];
    self.buttonView.SILK_bottom = self.SILK_height - 82;
    self.buttonView.SILK_centerX = self.SILK_centerX;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSlideUpView];
    }
    
    return self;
}

- (void)setupSlideUpView {
    self.buttonView = [[SILKSplashSlideUpButton alloc] init];
    self.buttonView.SILK_bottom = self.SILK_height - 82;
    self.buttonView.SILK_centerX = self.SILK_width / 2;
    [self addSubview:self.buttonView];
    
    if ([self.slideView superview] != nil) {
        [self.slideView removeFromSuperview];
    }
    self.slideView = [[SILKSplashSlideUpView alloc] init];
    self.slideView.SILK_width = 48.f;
    self.slideView.SILK_height = 32.f;
    self.slideView.SILK_centerX = self.SILK_width / 2;
    self.slideView.SILK_bottom = self.buttonView.SILK_top - 12.f;
    [self addSubview:self.slideView];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.values = @[@(self.buttonView.SILK_top - 28.f), @(self.buttonView.SILK_top - 38.f), @(self.buttonView.SILK_top - 28.f)];
    positionAnimation.duration = 1;

    CAKeyframeAnimation *opaqueAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opaqueAnimation.values = @[@1, @0.8, @1];
    opaqueAnimation.duration = 1;

    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.beginTime = CACurrentMediaTime();
    groupAnimation.animations = @[positionAnimation, opaqueAnimation];

    groupAnimation.duration = 1;
    groupAnimation.repeatCount = NSUIntegerMax;
    [self.slideView.layer addAnimation:groupAnimation forKey:nil];
}

@end
