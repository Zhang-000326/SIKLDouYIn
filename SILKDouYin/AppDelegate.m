//
//  AppDelegate.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/8.
//

#import "AppDelegate.h"

#import "SILKMainManagerProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = (UIViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKMainManager) mainTabBarController];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

@end
