//
//  SILKSplashPageContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/25.
//

#import "SILKSplashPageContainer.h"

#import "SILKSplashPageView.h"

#import "SILKCommerceDefine.h"

@implementation SILKSplashPageContainer

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self setupPageView];
        [self setupPageShadow];
    }
    
    return self;
}

- (void)setupPageView {
    self.pageView = [[SILKSplashPageView alloc] initWithFrame:self.bounds];

    [self.pageView startGuideAnimation];
    
    NSString *text = @"左滑前往落地页";
    [self.pageView setTipsText:text];

    [self addSubview:self.pageView];
    [self.pageView loadLabelAnimation];
}

- (void)setupPageShadow {
    self.gradintLayer = [CAGradientLayer layer];
    self.gradintLayer.frame = CGRectMake(self.frame.size.width - 106.f, 0, 106.f, self.frame.size.height);
    self.gradintLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor];
    self.gradintLayer.startPoint = CGPointMake(0, 0);
    self.gradintLayer.endPoint = CGPointMake(1.f, 0);
    self.gradintLayer.locations = @[@0, @1];
    [self.layer addSublayer:self.gradintLayer];
}
@end
