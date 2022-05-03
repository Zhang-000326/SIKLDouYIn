//
//  SILKCommerceManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/7.
//

#import "SILKCommerceManager.h"

#import "SILKSplashDelegate.h"

#import "SILKSplashView.h"
#import "SILKWebViewController.h"

#import "SILKCommerceDefine.h"

// others
#import "SILKMainManagerProtocol.h"

#import <WebKit/WebKit.h>

@interface SILKCommerceManager () <SILKSplashDelegate>

@property (nonatomic, strong) SILKSplashView *splashView;

@end

@implementation SILKCommerceManager

BIND_PROTOCOL(SILKCommerceManager);

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKCommerceManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKCommerceManager alloc] initPrivate];
    });
    return instance;
}

- (void)displaySplashFor:(SILKSplashComplianceType)type {
    CGRect splashFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.splashView = [[SILKSplashView alloc] initWithFrame:splashFrame complianceType:type delegate:self];
    [[UIWindow SILK_keyWindow] addSubview:self.splashView];
}

#pragma mark - SILKSplashProtocol

- (void)splashViewShowFinished {
    [self.splashView removeFromSuperview];
    self.splashView = nil;
}

- (void)openWebViewWithAnimationBlock:(SILKSplashAnimationBlock)animationBlock andType:(SILKSplashComplianceType)type {
    NSString *web_url = @"https://www.bilibili.com/";
    
    SILKWebViewController *webVC = [[SILKWebViewController alloc] initWithUrl:web_url];
    if (animationBlock) {
        [[UIWindow SILK_keyWindow] addSubview:webVC.view];
        
        UIView *toView = webVC.view;
        
        switch (type) {
            case SILKSplashComplianceTypeSlideUp: {
                toView.frame = CGRectMake(0, SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_HEIGHT);
                [UIView animateWithDuration:0.4f animations:^{
                    toView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
                }];
            } break;
            case SILKSplashComplianceTypeSlideSide: {
                toView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                [UIView animateWithDuration:0.3f animations:^{
                    toView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
                }];
            } break;
            default:
                break;
        }
        
        animationBlock(YES);
    } else {
        [[UIWindow SILK_keyWindow] addSubview:webVC.view];
    }
}

@end
