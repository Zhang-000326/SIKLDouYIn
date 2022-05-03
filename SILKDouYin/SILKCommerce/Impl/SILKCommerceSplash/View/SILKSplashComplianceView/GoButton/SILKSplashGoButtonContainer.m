//
//  SILKSplashGoButtonContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/13.
//

#import "SILKSplashGoButtonContainer.h"

#import "SILKSplashGoButtonView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashGoButtonContainer ()

@end

@implementation SILKSplashGoButtonContainer

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.goButtonView.SILK_centerX = self.SILK_centerX;
    self.goButtonView.SILK_bottom = self.SILK_height - 56.f;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGoButtonView];
    }
    
    return self;
}

- (void)setupGoButtonView {

    
    self.goButtonView = [[SILKSplashGoButtonView alloc] initWithFrame:CGRectMake(0, 0, 334.f, 126.f)];
    self.goButtonView.SILK_centerX = self.SILK_centerX;
    self.goButtonView.SILK_bottom = self.SILK_height - 80.f;
    [self addSubview:self.goButtonView];
    
    NSString *firstTitle = @"点击查看详情";
    NSString *secondTitle = @"即将跳转至落地页";
    [self.goButtonView setupWithfirstTitle:firstTitle secondTitle:secondTitle];
}

@end
