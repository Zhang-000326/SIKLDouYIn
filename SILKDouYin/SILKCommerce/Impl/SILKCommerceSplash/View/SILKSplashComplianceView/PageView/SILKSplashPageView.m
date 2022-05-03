//
//  SILKSplashPageView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/24.
//

#import "SILKSplashPageView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashPageView ()

@property (nonatomic, assign) CGPoint aPoint;
@property (nonatomic, assign) CGPoint bPoint;
@property (nonatomic, assign) CGPoint cPoint;
@property (nonatomic, assign) CGPoint dPoint;
@property (nonatomic, assign) CGPoint ePoint;
@property (nonatomic, assign) CGPoint fPoint;
@property (nonatomic, assign) CGPoint gPoint;
@property (nonatomic, assign) CGPoint hPoint;
@property (nonatomic, assign) CGPoint iPoint;
@property (nonatomic, assign) CGPoint jPoint;
@property (nonatomic, assign) CGPoint kPoint;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *shadowMaskLayer;
@property (nonatomic, strong) CAGradientLayer *pageGradintLayer;    ///< 翻页时的阴影

@property (nonatomic, strong) UIView *pageShadowView;
@property (nonatomic, strong) UIView *pageView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIView *imageView;
@property (nonatomic, strong) UIImageView *loadView;

@property (nonatomic, strong) CADisplayLink *guideDisplayLink;  ///< 引导时的翻页帧动画
@property (nonatomic, assign) NSUInteger frameIndex;

@property (nonatomic, strong) CADisplayLink *displayLink;   ///< 松手后的翻页滑动帧动画

@property (nonatomic, assign) CGFloat deltaX;   ///< 松手后的翻页滑动位移（0.4s内每帧移动的位移）
@property (nonatomic, assign) CGFloat deltaY;
@property (nonatomic, assign) BOOL isAnimationCancel;

@end

@implementation SILKSplashPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.fPoint = CGPointMake(frame.size.width, frame.size.height);
        self.startPoint = self.fPoint;
        self.aPoint = self.fPoint;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        [self addSubview:self.tipsLabel];
        [self addSubview:self.imageView];
        
        self.pageView = [[UIView alloc] initWithFrame:frame];
        self.pageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pageView];
        
        self.maskLayer = [CAShapeLayer layer];
        self.maskLayer.lineWidth = 1.f;
        self.maskLayer.strokeColor = [UIColor clearColor].CGColor;
        self.pageView.layer.mask = self.maskLayer;
        
        self.loadView.SILK_centerX = frame.size.width / 2;
        self.loadView.SILK_centerY = frame.size.height / 2;
        [self.pageView addSubview:self.loadView];
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.lineWidth = 1.f;
        self.shapeLayer.hidden = YES;
        [self.pageView.layer addSublayer:self.shapeLayer];
        
        self.pageShadowView = [[UIView alloc] initWithFrame:frame];
        self.pageShadowView.backgroundColor = [UIColor clearColor];
        [self.pageView addSubview:self.pageShadowView];
        
        self.pageGradintLayer = [CAGradientLayer layer];
        self.pageGradintLayer.frame = frame;
        self.pageGradintLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.f].CGColor];
        self.pageGradintLayer.startPoint = CGPointMake(0, 0);
        self.pageGradintLayer.endPoint = CGPointMake(1, 0);
        self.pageGradintLayer.locations = @[@0, @1];
        [self.pageShadowView.layer addSublayer:self.pageGradintLayer];

        self.shadowMaskLayer = [CAShapeLayer layer];
        self.shadowMaskLayer.strokeColor = [UIColor clearColor].CGColor;
        self.pageShadowView.layer.mask = self.shadowMaskLayer;
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        self.displayLink.paused = YES;
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        self.guideDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(guideStep)];
        self.guideDisplayLink.paused = YES;
        [self.guideDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)setTipsText:(NSString *)text {
    if (SILK_isEmptyString(text)) {
        self.tipsLabel.text = text;
    } else {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3.f;
        shadow.shadowOffset = CGSizeMake(0,0);
        shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIFont *font = [UIFont systemFontOfSize:14.f];
        if (@available(iOS 8.2, *)) {
            font = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        }
        UIColor *color = [UIColor whiteColor];
        NSDictionary *attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSShadowAttributeName:shadow};
        // 获取单个汉字的宽度，用于竖排文本
        CGSize wordSize = [@"一" boundingRectWithSize:CGSizeMake(0,0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;

        self.tipsLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.frame = CGRectMake(0, 0, wordSize.width, 0);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
        self.tipsLabel.attributedText = string;
    }
    [self.tipsLabel sizeToFit];
    
    CGFloat height = self.tipsLabel.SILK_height + 6.f + self.imageView.SILK_height;
    self.tipsLabel.SILK_top = (self.SILK_height - height) / 2;
    self.tipsLabel.SILK_right = self.SILK_width;
    self.imageView.SILK_top = self.tipsLabel.SILK_bottom + 6.f;
    self.imageView.SILK_right = self.SILK_width - 11.75;
}

- (void)loadLabelAnimation {
    // 文本框的位移延时 0.5s
    CABasicAnimation *opacityIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityIncreaseAnimation.fromValue = @0;
    opacityIncreaseAnimation.toValue = @1;
    opacityIncreaseAnimation.duration = 0.4;
    opacityIncreaseAnimation.beginTime = CACurrentMediaTime() + 0.5;
    opacityIncreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
    opacityIncreaseAnimation.removedOnCompletion = NO;
    opacityIncreaseAnimation.fillMode = kCAFillModeForwards;
    [self.tipsLabel.layer addAnimation:opacityIncreaseAnimation forKey:nil];

    CABasicAnimation *positionLeftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionLeftAnimation.fromValue = @(self.tipsLabel.layer.position.x);
    positionLeftAnimation.toValue = @(self.tipsLabel.layer.position.x - 15);
    positionLeftAnimation.duration = 0.9;
    positionLeftAnimation.beginTime = CACurrentMediaTime() + 0.5;
    positionLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
    positionLeftAnimation.removedOnCompletion = NO;
    positionLeftAnimation.fillMode = kCAFillModeForwards;
    [self.tipsLabel.layer addAnimation:positionLeftAnimation forKey:nil];
    
    self.imageView.SILK_right = self.SILK_width - 11.75;
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:CGPointMake(self.imageView.SILK_right, self.imageView.SILK_top)];
    [triangle addLineToPoint:CGPointMake(self.imageView.SILK_right - 4.5, self.imageView.SILK_top + 4.5)];
    [triangle addLineToPoint:CGPointMake(self.imageView.SILK_right, self.imageView.SILK_bottom)];
    triangle.lineWidth = 3.f;
    triangle.lineCapStyle = kCGLineCapRound;
    triangle.lineJoinStyle = kCGLineJoinRound;
    
    for (NSUInteger index = 0; index < 3; index++) {
        CGFloat beginTime = 0.3 * index + 0.9;
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.path = triangle.CGPath;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.opacity = 0.f;
        shapeLayer.fillColor = nil;
        shapeLayer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
        shapeLayer.shadowOffset = CGSizeMake(0,0);
        shapeLayer.shadowRadius = 3.f;
        [self.layer addSublayer:shapeLayer];
        
        CAKeyframeAnimation *opaqueAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opaqueAnimation.values = @[@0, @1, @0];
        opaqueAnimation.keyTimes = @[@0, @(0.76/1.32), @1];
        opaqueAnimation.duration = 1.32;

        CABasicAnimation *positionXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        positionXAnimation.fromValue =  @(shapeLayer.position.x);
        positionXAnimation.toValue =  @(shapeLayer.position.x - 15);
        positionXAnimation.duration = 1.32;
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.beginTime = CACurrentMediaTime() + beginTime;
        groupAnimation.animations = @[opaqueAnimation, positionXAnimation];
        groupAnimation.duration = 1.32;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        groupAnimation.repeatCount = NSUIntegerMax;
        [shapeLayer addAnimation:groupAnimation forKey:nil];
    }
}

- (void)moveToPoint:(CGPoint)point {
    CGPoint newPoint = CGPointMake(point.x - self.startPoint.x + self.fPoint.x, point.y - self.startPoint.y + self.fPoint.y);
    if (newPoint.y >= self.frame.size.height) {
        newPoint = CGPointMake(newPoint.x, self.frame.size.height - 1.f);
    }
    if (newPoint.x >= self.frame.size.width) {
        newPoint = CGPointMake(self.frame.size.width - 1.f, newPoint.y);
    }
    self.aPoint = newPoint;
    if (self.cPoint.x < 0) {
        CGFloat w0 = self.fPoint.x - self.cPoint.x;
        CGFloat w1 = self.fPoint.x - self.aPoint.x;
        CGFloat w2 = self.fPoint.x * w1 / w0;
        CGFloat h1 = self.fPoint.y - self.aPoint.y;
        CGFloat h2 = w2 * h1 / w1;
        self.aPoint = CGPointMake(self.fPoint.x - w2, self.fPoint.y - h2);
    }
    self.shapeLayer.hidden = NO;
    self.displayLink.paused = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pageViewAnimationCancel) object:nil];

    [self performPageAnimation];
    [self setNeedsDisplay];
}

- (void)startGuideAnimation {
    self.guideDisplayLink.paused = NO;
    [self performSelector:@selector(guideViewAnimationCancel) withObject:nil afterDelay:3.7f];
}

- (void)addPageViewAnimationWithType:(NSInteger)type {
    CGFloat targetX = type == 0 ? self.frame.size.width : -self.frame.size.width;
    self.isAnimationCancel = type == 0;
    self.deltaX = (self.aPoint.x - targetX) / (0.4f * 60);
    self.deltaY = (self.aPoint.y - self.frame.size.height) / (0.4f * 60);
    self.displayLink.paused = NO;
    [self performSelector:@selector(pageViewAnimationCancel) withObject:nil afterDelay:0.5f];
}

- (void)pageViewAnimationCancel {
    self.displayLink.paused = YES;
}

- (void)guideViewAnimationCancel {
    if (self.guideDisplayLink) {
        [self.guideDisplayLink invalidate];
        self.guideDisplayLink = nil;
    }
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    if (self.guideDisplayLink) {
        [self.guideDisplayLink invalidate];
        self.guideDisplayLink = nil;
    }
}

#pragma mark - private methods

- (void)performPageAnimation {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.shadowMaskLayer.path = [self getPagePathC].CGPath;
    self.pageGradintLayer.frame = [self getShadowFrame];
    self.pageGradintLayer.endPoint = [self getEndPoint];
    self.maskLayer.path = [self getPagePathMask].CGPath;
    self.shapeLayer.path = [self getPagePathC].CGPath;
    [CATransaction commit];
}

- (void)step {
    self.aPoint = CGPointMake(self.aPoint.x - self.deltaX, self.aPoint.y - self.deltaY);
    CGFloat maxX;
    CGFloat maxY;
    if (self.isAnimationCancel) {
        maxX = self.aPoint.x < self.frame.size.width ? self.aPoint.x : self.frame.size.width - 1.f;
    } else {
        maxX = self.aPoint.x > -self.frame.size.width ? self.aPoint.x : -self.frame.size.width + 1.f;
    }
    maxY = self.aPoint.y < (self.frame.size.height - 1.f) ? self.aPoint.y : self.frame.size.height - 1.f;
    self.aPoint = CGPointMake(maxX, maxY);
    [self performPageAnimation];
    [self setNeedsDisplay];
}

- (void)guideStep {
    CGPoint deltaPoint1 = CGPointMake(100.f / 60, 12.f / 60);
    CGPoint deltaPoint2 = CGPointMake(-50.f / (0.4 * 60), 0);
    if (self.frameIndex < 60) {
        self.aPoint = CGPointMake(self.aPoint.x - deltaPoint1.x, self.aPoint.y - deltaPoint1.y);
    } else if (self.frameIndex < 84) {
        self.aPoint = CGPointMake(self.aPoint.x - deltaPoint2.x, self.aPoint.y - deltaPoint2.y);
    } else if (self.frameIndex < 132) {
        self.aPoint = self.aPoint;
    } else if (self.frameIndex < 156) {
        self.aPoint = CGPointMake(self.aPoint.x + deltaPoint2.x, self.aPoint.y + deltaPoint2.y);
    } else if (self.frameIndex < 216) {
        self.aPoint = CGPointMake(self.aPoint.x + deltaPoint1.x, self.aPoint.y + deltaPoint1.y);
    }
    self.frameIndex ++;
    [self performPageAnimation];
    [self setNeedsDisplay];
}

- (CGPoint)getEndPoint {
    CGFloat deltaX = self.fPoint.x - self.aPoint.x;
    CGFloat deltaY = self.fPoint.y - self.aPoint.y;
    if (deltaY == 0) {
        return CGPointMake(1, 0);
    }
    CGFloat pointX = deltaX > deltaY ? 1 : deltaX / deltaY;
    CGFloat pointY = deltaX > deltaY ? deltaY / deltaX : 1;
    return CGPointMake(pointX, pointY);
}

- (CGRect)getShadowFrame {
    CGFloat pointX = self.aPoint.x > self.cPoint.x ? self.cPoint.x : self.aPoint.x;
    CGFloat pointY = self.aPoint.y > self.jPoint.y ? self.jPoint.y : self.aPoint.y;
    return CGRectMake(pointX, pointY, self.fPoint.x - pointX, self.fPoint.y - pointY);
}

- (UIBezierPath *)getPagePathC {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:self.iPoint];
    [path moveToPoint:self.kPoint];
    [path addLineToPoint:self.aPoint];
    [path addLineToPoint:self.bPoint];
    [path addLineToPoint:self.dPoint];
    [path addLineToPoint:self.iPoint];
    [path closePath];
    return path;
}

- (UIBezierPath *)getPagePathMask {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:self.jPoint];
    [path addQuadCurveToPoint:self.kPoint controlPoint:self.hPoint];
    [path addLineToPoint:self.aPoint];
    [path addLineToPoint:self.bPoint];
    [path addQuadCurveToPoint:self.cPoint controlPoint:self.ePoint];
    [path addLineToPoint:self.fPoint];
    [path addLineToPoint:self.jPoint];
    [path closePath];
    return path;
}

- (CGPoint)getIntersectionPointWithAPoint:(CGPoint)aPoint bPoint:(CGPoint)bPoint cPoint:(CGPoint)cPoint dPoint:(CGPoint)dPoint {
    CGFloat x = ((dPoint.x * cPoint.y - dPoint.y * cPoint.x) * (bPoint.x - aPoint.x) - (bPoint.x * aPoint.y - bPoint.y * aPoint.x) * (dPoint.x - cPoint.x)) / ((bPoint.y - aPoint.y) * (dPoint.x - cPoint.x) - (dPoint.y - cPoint.y) * (bPoint.x - aPoint.x));
    CGFloat y = (bPoint.y - aPoint.y) * x / (bPoint.x - aPoint.x) + (bPoint.x * aPoint.y - bPoint.y * aPoint.x) / (bPoint.x - aPoint.x);
    return CGPointMake(x, y);
}

#pragma mark - getter

- (CGPoint)aPoint {
    return _aPoint;
}

- (CGPoint)fPoint {
    return _fPoint;
}

- (CGPoint)gPoint {
    return CGPointMake((self.aPoint.x + self.fPoint.x) / 2, (self.aPoint.y + self.fPoint.y) / 2);
}

- (CGPoint)ePoint {
    return CGPointMake(self.gPoint.x - (self.fPoint.y - self.gPoint.y) * (self.fPoint.y - self.gPoint.y) / (self.fPoint.x - self.gPoint.x), self.fPoint.y);
}

- (CGPoint)hPoint {
    return CGPointMake(self.fPoint.x, self.gPoint.y - (self.fPoint.x - self.gPoint.x) * (self.fPoint.x - self.gPoint.x) / (self.fPoint.y - self.gPoint.y));
}

- (CGPoint)cPoint {
    return CGPointMake(self.ePoint.x - (self.fPoint.x - self.ePoint.x) / 2, self.fPoint.y);
}

- (CGPoint)jPoint {
    return CGPointMake(self.fPoint.x, self.hPoint.y - (self.fPoint.y - self.hPoint.y) / 2);
}

- (CGPoint)dPoint {
    return CGPointMake((self.cPoint.x + 2 * self.ePoint.x + self.bPoint.x) / 4, (self.cPoint.y + 2 * self.ePoint.y + self.bPoint.y) / 4);
}

- (CGPoint)iPoint {
    return CGPointMake((self.jPoint.x + 2 * self.hPoint.x + self.kPoint.x) / 4, (self.jPoint.y + 2 * self.hPoint.y + self.kPoint.y) / 4);
}

- (CGPoint)bPoint {
    return [self getIntersectionPointWithAPoint:self.aPoint bPoint:self.ePoint cPoint:self.cPoint dPoint:self.jPoint];
}

- (CGPoint)kPoint {
    return [self getIntersectionPointWithAPoint:self.aPoint bPoint:self.hPoint cPoint:self.cPoint dPoint:self.jPoint];
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14.f];
        _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _tipsLabel.alpha = 0.f;
    }
    return _tipsLabel;
}

- (UIView *)imageView {
    if (!_imageView) {
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.f, 9.f)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    
    return _imageView;
}

- (UIImageView *)loadView {
    if (!_loadView) {
        _loadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 147.6f, 32.8f)];
        _loadView.backgroundColor = [UIColor clearColor];
        UIImage *pageImage = [UIImage SILK_imageWithColor:[UIColor colorWithWhite:1 alpha:1] size:CGSizeMake(self.SILK_width, self.SILK_height)];
        [_loadView setImage:pageImage];
    }
    return _loadView;
}

@end
