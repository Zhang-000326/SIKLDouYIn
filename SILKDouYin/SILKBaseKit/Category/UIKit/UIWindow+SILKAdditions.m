//
//  UIWindow+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import "UIWindow+SILKAdditions.h"

@implementation UIWindow (SILKAdditions)

+ (UIWindow *)SILK_keyWindow {
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        // Find active key window from UIScene
        NSInteger activeWindowSceneCount = 0;
        NSSet *connectedScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIScene *scene in connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                activeWindowSceneCount++;
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                if (!keyWindow) {
                    keyWindow = [self SILK_keyWindowFromWindowScene:windowScene];
                }
            }
        }
        
        // If there're multiple active window scenes, get the key window from the currently focused window scene to keep the behavior consistent with [UIApplication sharedApplication].keyWindow
        if (activeWindowSceneCount > 1) {
            // Although [UIApplication sharedApplication].keyWindow is deprecated for iOS 13+, it can help to find the focused one when multiple scenes in the foreground
            keyWindow = [self SILK_keyWindowFromWindowScene:[UIApplication sharedApplication].keyWindow.windowScene];
        }
        
        // Sometimes there will be no active scene in foreground, loop through the application windows for the key window
        if (!keyWindow) {
            for (UIWindow *window in [UIApplication sharedApplication].windows) {
                if (window.isKeyWindow) {
                    keyWindow = window;
                    break;
                }
            }
        }
        
        // Check to see if the app key window is true and add protection
        if (!keyWindow && [UIApplication sharedApplication].keyWindow.isKeyWindow) {
            keyWindow = [UIApplication sharedApplication].keyWindow;
        }
        
        // Still nil ? Add protection to always fallback to the application delegate's window.
        // There's a chance when delegate doesn't respond to window, so add protection here
        if (!keyWindow && [[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            keyWindow = [UIApplication sharedApplication].delegate.window;
        }
    } else {
        // Fall back to application's key window below iOS 13
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    return keyWindow;
}

+ (UIWindow *)SILK_keyWindowFromWindowScene:(id)windowScene {
    if (@available(iOS 13.0, *)) {
        if ([windowScene isKindOfClass:[UIWindowScene class]]) {
            for (UIWindow *window in ((UIWindowScene *)windowScene).windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return nil;
}

@end
