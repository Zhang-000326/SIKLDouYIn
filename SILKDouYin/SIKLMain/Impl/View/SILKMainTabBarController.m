//
//  SILKMainTabBarController.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import "SILKMainTabBarController.h"

#import "SILKMainTabBar.h"




// 工具类
#import "SILKBaseKit.h"

@interface SILKMainTabBarController ()

@property (nonatomic, strong) SILKMainTabBar *mainTabBar;


@end

@implementation SILKMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTabBar];
}

- (void)loadTabBar {
    // 替换系统tabbar
    [self setValue:self.mainTabBar forKey:@"tabBar"];
    
    self.mainTabBar.backgroundImage = [UIImage SILK_imageWithColor:[UIColor colorWithWhite:0 alpha:1] size:CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT)];
    self.mainTabBar.barTintColor = [UIColor colorWithWhite:0 alpha:1];
    self.mainTabBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
//    self.mainTabBar.translucent = NO;
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title {
    childVC.tabBarItem.title = title;
    [self setTabbarForVC:childVC];

    childVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -40);
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(28, 0, -28, 0);

    [self addChildViewController:childVC];
}

- (void)setTabbarForVC:(UIViewController *)vc {
    
    UIImage *normalImage = [UIImage SILK_imageWithColor:UIColor.clearColor size:CGSizeMake(1, 1)];;
    UIImage *selectImage = [UIImage SILK_imageWithColor:[UIColor whiteColor] size:CGSizeMake(36, 3)];
    UIColor *normalTitleColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    UIColor *selectTitleColor = UIColor.whiteColor;
    UIFont *normalTitleFont = [UIFont boldSystemFontOfSize:15];
    UIFont *selectTitleFont = [UIFont boldSystemFontOfSize:16];
    UIImage *backgroundImage = [UIImage SILK_imageWithColor:[UIColor colorWithWhite:0 alpha:0.8] size:CGSizeMake(SCREEN_WIDTH, TABBAR_HEIGHT)];;
    UIImage *shadowImage = [UIImage SILK_imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.2] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];;
    
    vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *normalTitleAttr = @{NSFontAttributeName: normalTitleFont, NSForegroundColorAttributeName: normalTitleColor};
    NSDictionary *selectTitleAttr = @{NSFontAttributeName: selectTitleFont, NSForegroundColorAttributeName: selectTitleColor};
    if (@available(iOS 13.0, *)) {
        void (^tabBarAppearanceBlock)(UITabBarItemAppearance * _Nullable itemAppearance) = ^(UITabBarItemAppearance * _Nullable itemAppearance){
            itemAppearance.normal.titleTextAttributes = normalTitleAttr;
            itemAppearance.selected.titleTextAttributes = selectTitleAttr;
        };
        
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        tabBarAppearanceBlock(appearance.stackedLayoutAppearance);
        tabBarAppearanceBlock(appearance.inlineLayoutAppearance);
        tabBarAppearanceBlock(appearance.compactInlineLayoutAppearance);
        
        appearance.backgroundEffect = nil;
        appearance.shadowImage = shadowImage;
        appearance.backgroundImage = backgroundImage;
        vc.tabBarItem.standardAppearance = appearance;
    }else {
        [vc.tabBarItem setTitleTextAttributes:normalTitleAttr forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:selectTitleAttr forState:UIControlStateSelected];
    }
}

- (SILKMainTabBar *)mainTabBar {
    if (!_mainTabBar) {
        _mainTabBar = [[SILKMainTabBar alloc] init];
    }
    
    return _mainTabBar;
}

@end
