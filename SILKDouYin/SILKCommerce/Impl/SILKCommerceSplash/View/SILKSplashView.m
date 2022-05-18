//
//  SILKSplashView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashView.h"
#import "SILKSplashView+Gesture.h"

#import "SILKSplashDelegate.h"

#import "SILKSplashSkipView.h"

#import "SILKSplashButtonViewContainer.h"
#import "SILKSplashButtonView.h"

#import "SILKSplashSlideUpContainer.h"

#import "SILKSplashSlideSideContainer.h"

#import "SILKSplashGoButtonContainer.h"
#import "SILKSplashGoButtonView.h"

#import "SILKSplashShakeContainer.h"
#import "SILKSplashMotionManager.h"

#import "SILKSplashPageContainer.h"
#import "SILKSplashPageView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashView () <SILKSplashMotionDelegate>

@property (nonatomic, weak) id<SILKSplashDelegate> delegate;

@property (nonatomic, assign) SILKSplashComplianceType complianceType;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) SILKSplashSkipView *skipView;
@property (nonatomic, strong) SILKSplashButtonViewContainer *buttonContainer;
@property (nonatomic, strong) SILKSplashSlideUpContainer *slideUpContainer;
@property (nonatomic, strong) SILKSplashSlideSideContainer *slideSideContainer;
@property (nonatomic, strong) SILKSplashGoButtonContainer *goButtonContainer;
@property (nonatomic, strong) SILKSplashShakeContainer *shakeContainer;
@property (nonatomic, strong) SILKSplashPageContainer *pageContainer;

@property (nonatomic, assign) BOOL markWillDismiss;
@property (nonatomic, assign) BOOL pageViewIsOver;
@property (nonatomic, assign) BOOL pageViewIsShowing;      
@property (nonatomic, assign) BOOL jumpAnimationIsShowing;  ///< 跳转动画正在执行中，避免开屏页因为展示时间而直接退出

@end

@implementation SILKSplashView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = self.superview.bounds;
    
}

#pragma mark - Public Method

- (instancetype)initWithFrame:(CGRect)frame
               complianceType:(SILKSplashComplianceType)type
                     delegate:(id<SILKSplashDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
        self.complianceType = type;
        [self setupViews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)setupViews {
    [self addSubview:self.imageView];
    [self setupComplianceView];
    [self addSubview:self.skipView];
    
    [self performSelector:@selector(splashShowTimeOut) withObject:nil afterDelay:4.f];
}

- (void)setupComplianceView {
    switch (self.complianceType) {
        case SILKSplashComplianceTypeSlideUp:
            [self setupSlideUpView];
            break;
        case SILKSplashComplianceTypeSlideSide:
            [self setupSlideSideView];
            break;
        case SILKSplashComplianceTypeGoButton:
            [self setupGoButtonView];
            break;
        case SILKSplashComplianceTypeShake:
            [self setupShakeView];
            break;
        case SILKSplashComplianceTypePage:
            [self setupPageView];
            break;
        default:
            [self setupButtonView];
            break;
    }
}

- (void)setupButtonView {
    self.buttonContainer = [[SILKSplashButtonViewContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.buttonContainer];
    
    SILKBaseTapGestureRecognizer *tapGesture = [[SILKBaseTapGestureRecognizer alloc] initWithTarget:self action:@selector(splashClicked)];
    [self.buttonContainer.buttonView addGestureRecognizer:tapGesture];
}

- (void)setupSlideUpView {
    self.slideUpContainer = [[SILKSplashSlideUpContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.slideUpContainer];
    
    SILKBasePanGestureRecognizer *slideGesture = [[SILKBasePanGestureRecognizer alloc] initWithTarget:self action:@selector(onSlidePanGesture:)];
    slideGesture.cancelsTouchesInView = NO;
    [self.slideUpContainer addGestureRecognizer:slideGesture];
}

- (void)setupSlideSideView {
    self.slideSideContainer = [[SILKSplashSlideSideContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.slideSideContainer];
    
    SILKBasePanGestureRecognizer *slideGesture = [[SILKBasePanGestureRecognizer alloc] initWithTarget:self action:@selector(onSlidePanGesture:)];
    slideGesture.cancelsTouchesInView = NO;
    [self.slideSideContainer addGestureRecognizer:slideGesture];
}

- (void)setupGoButtonView {
    self.goButtonContainer = [[SILKSplashGoButtonContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.goButtonContainer];
    
    SILKBaseTapGestureRecognizer *tapGesture = [[SILKBaseTapGestureRecognizer alloc] initWithTarget:self action:@selector(splashClicked)];
    [self.goButtonContainer.goButtonView addGestureRecognizer:tapGesture];
}

- (void)setupShakeView {
    self.shakeContainer = [[SILKSplashShakeContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.shakeContainer];
    [self.shakeContainer showShakeTipView];
    self.shakeContainer.delegate = self;
}

- (void)setupPageView {
    self.pageContainer = [[SILKSplashPageContainer alloc] initWithFrame:self.bounds];
    [self addSubview:self.pageContainer];
    
    SILKBasePanGestureRecognizer *pageGesture = [[SILKBasePanGestureRecognizer alloc] initWithTarget:self action:@selector(onPagePanGesture:)];
    pageGesture.cancelsTouchesInView = NO;
    [self.pageContainer addGestureRecognizer:pageGesture];
}

- (void)splashShowTimeOut {
    if (self.pageViewIsShowing) {
        self.pageViewIsOver = YES;
        return;
    }
    
    if (self.jumpAnimationIsShowing) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeLandPage)]) {
        [self.delegate removeLandPage];
    }
    
    [self splashCompletedWithAnimation:YES];
}

- (void)splashClickedWithAnimationBlock:(SILKSplashAnimationBlock)animationBlock andType:(SILKSplashComplianceType)type {
    if (self.delegate && [self.delegate respondsToSelector:@selector(openWebViewWithAnimationBlock:andType:)]) {
        [self.delegate openWebViewWithAnimationBlock:animationBlock andType:type];
    }
    
    [self splashCompletedWithAnimation:(animationBlock ? YES : NO)];
}

- (void)splashClicked {
    if (self.delegate && [self.delegate respondsToSelector:@selector(openWebViewWithAnimationBlock:andType:)]) {
        [self.delegate openWebViewWithAnimationBlock:nil andType:SILKSplashComplianceTypeButton];
    }
    
    [self splashCompletedWithAnimation:NO];
}

- (void)splashCompletedWithAnimation:(BOOL)animation {
    if (self.markWillDismiss) {
        return;
    }
    self.markWillDismiss = YES;
    
    // 先取消超时自动关闭
    [self invalidPerform];

    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(splashViewShowFinished)]) {
            [self.delegate splashViewShowFinished];
        }
    };
    
    if (animation) {
        [UIView animateWithDuration:0.4f animations:^{
            self.alpha = 0.f;
        } completion:completionBlock];
    } else {
        completionBlock(YES);
    }
    
}

- (void)invalidPerform {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - SILKSplashMotionDelegate

- (void)didReceiveShakeEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(openWebViewWithAnimationBlock:andType:)]) {
        [self.delegate openWebViewWithAnimationBlock:nil andType:SILKSplashComplianceTypeShake];
    }
    
    [self splashCompletedWithAnimation:NO];
}

#pragma mark - Getter && Setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageWithData:[@"splash_image" SILK_dataFromLocalFileWithType:@"jpeg"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.frame = self.bounds;
    }
    
    return _imageView;
}

- (SILKSplashSkipView *)skipView {
    if (!_skipView) {
        _skipView = [[SILKSplashSkipView alloc] initWithFrame:CGRectMake(290, 60, 70, 26)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(splashShowTimeOut)];
        [_skipView addGestureRecognizer:tapGesture];
    }
    
    return _skipView;
}

@end
