//
//  SILKSplashSlideUpView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashSlideUpView.h"



#import "SILKCommerceDefine.h"

@implementation SILKSplashSlideUpView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.34f].CGColor;
        self.layer.cornerRadius = 16.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

 - (void)drawRect:(CGRect)rect {
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f] set];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [rectPath fill];
    [rectPath stroke];

    [[UIColor whiteColor] set];

    UIBezierPath *path0 = [UIBezierPath bezierPath];
    [path0 moveToPoint:CGPointMake(17.63f, 15.f)];
    [path0 addLineToPoint:CGPointMake(23.315f, 11.f)];
    [path0 addLineToPoint:CGPointMake(29.f, 15.f)];

    path0.lineWidth = 2.f;
    path0.lineCapStyle = kCGLineCapRound;
    path0.lineJoinStyle = kCGLineJoinRound;

    [path0 stroke];

    [[UIColor colorWithWhite:1.f alpha:0.53f] set];

    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(17.63f, 21.5f)];
    [path1 addLineToPoint:CGPointMake(23.315f, 17.5f)];
    [path1 addLineToPoint:CGPointMake(29.f, 21.5f)];

    path1.lineWidth = 2.f;
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineJoinRound;

    [path1 stroke];
}

@end
