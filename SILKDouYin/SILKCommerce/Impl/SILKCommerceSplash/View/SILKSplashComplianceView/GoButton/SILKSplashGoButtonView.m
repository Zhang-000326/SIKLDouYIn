//
//  SILKSplashGoButtonView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/13.
//

#import "SILKSplashGoButtonView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashGoButtonView ()

@property (nonatomic, strong) UIView *bgButtonView;
@property (nonatomic, strong) UIView *goView;
@property (nonatomic, strong) UILabel *goLabel;
@property (nonatomic, strong) UIView *arrowView;

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *firstTitleLabel;
@property (nonatomic, strong) UILabel *secondTitleLabel;

@property (nonatomic, strong) CAShapeLayer *firstBreathLayer;
@property (nonatomic, strong) CAShapeLayer *secondBreathLayer;

@end

@implementation SILKSplashGoButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgButtonView];
        [self.bgButtonView addSubview:self.firstTitleLabel];
        [self.bgButtonView addSubview:self.secondTitleLabel];
        [self.bgButtonView addSubview:self.goView];
        [self.bgButtonView addSubview:self.titleView];
        
        [self.layer addSublayer:self.firstBreathLayer];
        [self.layer addSublayer:self.secondBreathLayer];
        
        [self.goView addSubview:self.goLabel];
        [self.goView addSubview:self.arrowView];
    }
    return self;
}

- (void)layoutSubviews {
    self.bgButtonView.SILK_height = self.SILK_height - 40.f;
    self.bgButtonView.SILK_width = self.SILK_width - 40.f;
    self.bgButtonView.center = CGPointMake(self.SILK_width * 0.5f, self.SILK_height * 0.5f);
    self.bgButtonView.layer.cornerRadius = self.bgButtonView.SILK_height * 0.5f;
    
    self.goView.SILK_right = self.bgButtonView.SILK_width - 10.f;
}

- (void)setupWithfirstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle {
    [self.firstTitleLabel setText:firstTitle];
    [self.firstTitleLabel sizeToFit];
    [self.secondTitleLabel setText:secondTitle];
    [self.secondTitleLabel sizeToFit];
    if (self.firstTitleLabel.SILK_width > self.secondTitleLabel.SILK_width) {
        self.firstTitleLabel.SILK_centerX = self.titleView.SILK_centerX;
        self.secondTitleLabel.SILK_left = self.firstTitleLabel.SILK_left;
    } else {
        self.secondTitleLabel.SILK_centerX = self.titleView.SILK_centerX;
        self.firstTitleLabel.SILK_left = self.secondTitleLabel.SILK_left;
    }
    
    self.bgButtonView.SILK_height = self.SILK_height - 40.f;
    self.bgButtonView.SILK_width = self.SILK_width - 40.f;
    self.bgButtonView.center = CGPointMake(self.SILK_width * 0.5f, self.SILK_height * 0.5f);
    
    [self loadAnimation];
}

#pragma mark - private method

- (void)loadAnimation {
    [self loadGoViewAnimation];
    [self loadBannerViewBreathAnimation];
    [self loadGoArrowAnimation];
}

// GO图的缩放动画
- (void)loadGoViewAnimation {
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.fromValue = @(1.f);
    expandAnimation.toValue = @(1.15f);
    expandAnimation.duration = 0.5;
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.fromValue = @(1.15f);
    narrowAnimation.toValue = @(1.f);
    narrowAnimation.duration = 0.15;
    narrowAnimation.beginTime = expandAnimation.beginTime + 0.5;
    
    CAAnimationGroup *scaleAnimationGroup = [CAAnimationGroup animation];
    scaleAnimationGroup.duration = 1.95;
    scaleAnimationGroup.animations = @[expandAnimation, narrowAnimation];
    scaleAnimationGroup.repeatCount = HUGE_VALF;
    scaleAnimationGroup.beginTime = CACurrentMediaTime();
    [self.goView.layer addAnimation:scaleAnimationGroup forKey:nil];
}

- (void)loadGoArrowAnimation {
    CAKeyframeAnimation *arrowAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    arrowAnimation.values = @[@51.f, @55.f, @51.f];
    arrowAnimation.keyTimes = @[@0, @0.5f, @1.f];
    arrowAnimation.duration = 0.66;
    arrowAnimation.repeatCount = HUGE_VALF;
    arrowAnimation.beginTime = CACurrentMediaTime();
    [self.arrowView.layer addAnimation:arrowAnimation forKey:nil];
}

//波纹效果的出现时机与GO图的缩放动画对应
- (void)loadBannerViewBreathAnimation {
    // 如果 maskPath，即中间需要挖去的部分，和按钮等大的话，在圆角部分会有部分差距，不能完全贴合，所以需要缩小一些
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.bgButtonView.SILK_left + 1.f, self.bgButtonView.SILK_top + 1.f, self.bgButtonView.SILK_width - 2.f, self.bgButtonView.SILK_height - 2.f) cornerRadius:self.bgButtonView.SILK_height * 0.5 - 1.f];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:self.bgButtonView.frame cornerRadius:self.bgButtonView.SILK_height * 0.5];
    [startPath appendPath:maskPath];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.SILK_width, self.SILK_height) cornerRadius:self.SILK_height * 0.5];
    [endPath appendPath:maskPath];
    
    CABasicAnimation *opacityIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityIncreaseAnimation.fromValue = @0;
    opacityIncreaseAnimation.toValue = @1;
    opacityIncreaseAnimation.duration = 0.1;
    opacityIncreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];

    CABasicAnimation *opacityDecreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityDecreaseAnimation.fromValue = @1;
    opacityDecreaseAnimation.toValue = @0;
    opacityDecreaseAnimation.duration = 1.7 / 3;
    opacityDecreaseAnimation.beginTime = opacityIncreaseAnimation.beginTime + 0.1;
    opacityDecreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
    
    CABasicAnimation *boundAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    boundAnimation.fromValue =  (__bridge id)(startPath.CGPath);
    boundAnimation.toValue = (__bridge id)(endPath.CGPath);
    boundAnimation.duration = 0.6;
    boundAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0 :1.0 :1.0];
    
    CAAnimationGroup *firstAnimationGroup = [CAAnimationGroup animation];
    firstAnimationGroup.duration = 1.95;
    firstAnimationGroup.beginTime = CACurrentMediaTime() + 0.65;
    firstAnimationGroup.animations = @[opacityIncreaseAnimation, opacityDecreaseAnimation, boundAnimation];
    firstAnimationGroup.repeatCount = HUGE_VALF;
    [self.firstBreathLayer addAnimation:firstAnimationGroup forKey:nil];
    
    CAAnimationGroup *secondAnimationGroup = [CAAnimationGroup animation];
    secondAnimationGroup.duration = 1.95;
    secondAnimationGroup.beginTime = firstAnimationGroup.beginTime - 0.15 + 2.0 / 3.0;
    secondAnimationGroup.animations = @[opacityIncreaseAnimation, opacityDecreaseAnimation, boundAnimation];
    secondAnimationGroup.repeatCount = HUGE_VALF;
    [self.secondBreathLayer addAnimation:secondAnimationGroup forKey:nil];
}

#pragma mark - getter & setter

- (UIView *)bgButtonView {
    if (!_bgButtonView) {
        _bgButtonView = [[UIView alloc] init];
        _bgButtonView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
        _bgButtonView.layer.borderColor = [UIColor SILK_colorWithHexString:@"FFFFFF4D"].CGColor;
        _bgButtonView.layer.borderWidth = 1.5f;
    }
    return _bgButtonView;
}

- (UIView *)goView {
    if (!_goView) {
        _goView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 66.f, 66.f)];
        _goView.backgroundColor = [UIColor whiteColor];
        _goView.layer.cornerRadius = 33.f;
    }
    return _goView;
}

- (UILabel *)goLabel {
    if (!_goLabel) {
        _goLabel = [[UILabel alloc] initWithFrame:CGRectMake(11.f, 15.f, 34.f, 36.f)];
        if (@available(iOS 8.2, *)) {
            _goLabel.font = [UIFont systemFontOfSize:22.f weight:UIFontWeightMedium];
        } else {
            _goLabel.font = [UIFont systemFontOfSize:22.f];
        }
        _goLabel.text = @"GO";
        _goLabel.textColor = [UIColor blackColor];
        _goLabel.backgroundColor = [UIColor clearColor];
    }
    return _goLabel;
}

- (UIView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIView alloc] initWithFrame:CGRectMake(47.f, 28.f, 8.f, 10.f)];
        _arrowView.backgroundColor = [UIColor clearColor];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(8.f, 5.f)];
        [path addLineToPoint:CGPointMake(0, 10.f)];
        [path addLineToPoint:CGPointMake(0, 0)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.lineWidth = 2.f;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.fillColor = [UIColor blackColor].CGColor;
        [_arrowView.layer addSublayer:shapeLayer];
    }
    return _arrowView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(32.f, 0, 162.f, 86.f)];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    return _titleView;
}

- (UILabel *)firstTitleLabel {
    if (!_firstTitleLabel) {
        _firstTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(52.f, 18.f, 132.f, 24.f)];
        _firstTitleLabel.font = [UIFont systemFontOfSize:22.f];
        _firstTitleLabel.textColor = [UIColor whiteColor];
        _firstTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _firstTitleLabel;
}

- (UILabel *)secondTitleLabel {
    if (!_secondTitleLabel) {
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(52.f, 48.f, 126.f, 20.f)];
        _secondTitleLabel.font = [UIFont systemFontOfSize:14.f];
        _secondTitleLabel.textColor = [UIColor whiteColor];
        _secondTitleLabel.textAlignment = NSTextAlignmentLeft;
        _secondTitleLabel.alpha = 0.7f;
    }
    return _secondTitleLabel;
}

- (CAShapeLayer *)firstBreathLayer {
    if (!_firstBreathLayer) {
        _firstBreathLayer = [CAShapeLayer layer];
        _firstBreathLayer.fillColor = [UIColor SILK_colorWithHexString:@"#FFFFFF3F"].CGColor;
        _firstBreathLayer.fillRule = kCAFillRuleEvenOdd;
        _firstBreathLayer.opacity = 0;
    }
    return _firstBreathLayer;
}

- (CAShapeLayer *)secondBreathLayer {
    if (!_secondBreathLayer) {
        _secondBreathLayer = [CAShapeLayer layer];
        _secondBreathLayer.fillColor = [UIColor SILK_colorWithHexString:@"#FFFFFF3F"].CGColor;
        _secondBreathLayer.fillRule = kCAFillRuleEvenOdd;
        _secondBreathLayer.opacity = 0;
    }
    return _secondBreathLayer;
}

@end
