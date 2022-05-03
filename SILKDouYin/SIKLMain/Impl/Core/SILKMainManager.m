//
//  SILKMainManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import "SILKMainManager.h"

// main
#import "SILKMainDefine.h"

// view
#import "SILKMainTabBarController.h"

// feed
#import "SILKFeedManagerProtocol.h"
#import "SILKFeedViewController.h"


// user
#import "SILKUserManagerProtocol.h"

// commerce
#import "SILKCommerceManagerProtocol.h"



@interface SILKMainManager ()

@end

@implementation SILKMainManager

BIND_PROTOCOL(SILKMainManager);

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        [self loadMainTabBarController];
    }
    
    return self;
}

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKMainManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKMainManager alloc] initPrivate];
    });
    return instance;
}

- (void)loadMainTabBarController {
    SILKFeedViewController *feedVC = [[SILKFeedViewController alloc] initWithFeedModels:[GET_INSTANCE_FROM_PROTOCOL(SILKFeedManager) feedModelArray]];
    feedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.mainTabBarController addChildVC:feedVC title:@"首页"];
    
    SILKBaseViewController *c2 = [[SILKBaseViewController alloc]init];
    c2.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self loadTestButtonForViewController:c2];
    [self.mainTabBarController addChildVC:c2 title:@"测试"];

    SILKBaseViewController *c3=[[SILKBaseViewController alloc]init];
    c3.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UILabel *tipsLabel3 = [[UILabel alloc] init];
    tipsLabel3.text = @"消息页";
    tipsLabel3.font = [UIFont systemFontOfSize:20.f];
    tipsLabel3.textColor = [UIColor whiteColor];
    [tipsLabel3 sizeToFit];
    tipsLabel3.center = c3.view.center;
    [c3.view addSubview:tipsLabel3];
    [self.mainTabBarController addChildVC:c3 title:@"消息"];

    
    SILKBaseViewController *c4 = (SILKBaseViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKUserManager) userViewController];
    [self.mainTabBarController addChildVC:c4 title:@"个人"];
    
    
}

- (NSInteger)currentTabBarItemsNumber {
    return self.mainTabBarController.viewControllers.count;
}

#pragma mark - Private Method

- (void)loadTestButtonForViewController:(UIViewController *)vc {
   
    UIButton *buttonSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    buttonSplashBtn.tag = SILKSplashComplianceTypeButton;
    [buttonSplashBtn setTitle:@"button splash" forState:UIControlStateNormal];
    [buttonSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [buttonSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:buttonSplashBtn];
    
    UIButton *slideUpSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 200, 50)];
    slideUpSplashBtn.tag = SILKSplashComplianceTypeSlideUp;
    [slideUpSplashBtn setTitle:@"slide up splash" forState:UIControlStateNormal];
    [slideUpSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    slideUpSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [slideUpSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:slideUpSplashBtn];
    
    UIButton *slideSideSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 200, 50)];
    slideSideSplashBtn.tag = SILKSplashComplianceTypeSlideSide;
    [slideSideSplashBtn setTitle:@"slide side splash" forState:UIControlStateNormal];
    [slideSideSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    slideSideSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [slideSideSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:slideSideSplashBtn];
    
    UIButton *goButtonSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 340, 200, 50)];
    goButtonSplashBtn.tag = SILKSplashComplianceTypeGoButton;
    [goButtonSplashBtn setTitle:@"go button splash" forState:UIControlStateNormal];
    [goButtonSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    goButtonSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [goButtonSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:goButtonSplashBtn];
    
    UIButton *shakeSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 420, 200, 50)];
    shakeSplashBtn.tag = SILKSplashComplianceTypeShake;
    [shakeSplashBtn setTitle:@"shake splash" forState:UIControlStateNormal];
    [shakeSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shakeSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [shakeSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:shakeSplashBtn];
    
    UIButton *pageSplashBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 200, 50)];
    pageSplashBtn.tag = SILKSplashComplianceTypePage;
    [pageSplashBtn setTitle:@"page splash" forState:UIControlStateNormal];
    [pageSplashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pageSplashBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    [pageSplashBtn addTarget:self action:@selector(showSplashForTest:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:pageSplashBtn];
}

- (void)showSplashForTest:(UIButton *)button {
    [GET_INSTANCE_FROM_PROTOCOL(SILKCommerceManager) displaySplashFor:button.tag];
}


#pragma mark - Getter && Setter

- (SILKMainTabBarController *)mainTabBarController {
    if (!_mainTabBarController) {
        _mainTabBarController = [[SILKMainTabBarController alloc] init];
    }
    
    return _mainTabBarController;
}

@end
