//
//  SILKUserManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import "SILKUserManager.h"

// user
#import "SILKUserDefine.h"

// view
#import "SILKUserViewController.h"
#import "SILKUserLoginView.h"


@interface SILKUserManager () <SILKUserLoginDelegate>

@property (nonatomic, strong) SILKUserLoginView *loginView;

@end

@implementation SILKUserManager

BIND_PROTOCOL(SILKUserManager);

- (instancetype)initPrivate {
    self = [super init];
    if (self) {

    }
    
    return self;
}

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKUserManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKUserManager alloc] initPrivate];
    });
    return instance;
}

- (void)loadLoginViewController {
    CGRect loginViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.loginView = [[SILKUserLoginView alloc] initWithFrame:loginViewFrame delegate:self];
    [[UIWindow SILK_keyWindow] addSubview:self.loginView];
}

#pragma mark - Private Method


#pragma mark - SILKUserLoginDelegate

- (void)loginViewShowFinished {
    [self.loginView removeFromSuperview];
    self.loginView = nil;
}

#pragma mark - Getter && Setter

- (SILKUserViewController *)userViewController {
    if (!_userViewController) {
        _userViewController = [[SILKUserViewController alloc] init];
    }
    
    return _userViewController;
}

@end
