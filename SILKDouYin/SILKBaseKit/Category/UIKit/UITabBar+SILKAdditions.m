//
//  UITabBar+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/13.
//

#import "UITabBar+SILKAdditions.h"

#import <objc/runtime.h>

#import "NSMethodSignature+SILKAdditions.h"

CG_INLINE BOOL
HasOverrideSuperclassMethod(Class targetClass, SEL targetSelector) {
    Method method = class_getInstanceMethod(targetClass, targetSelector);
    if (!method) return NO;
    
    Method methodOfSuperclass = class_getInstanceMethod(class_getSuperclass(targetClass), targetSelector);
    if (!methodOfSuperclass) return YES;
    
    return method != methodOfSuperclass;
}

CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id(^implementationBlock)(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void))) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    IMP imp = method_getImplementation(originMethod);
    BOOL hasOverride = HasOverrideSuperclassMethod(targetClass, targetSelector);
    
    // 以 block 的方式达到实时获取初始方法的 IMP 的目的，从而避免先 swizzle 了 subclass 的方法，再 swizzle superclass 的方法，会发现前者的方法调用不会触发后者 swizzle 后的版本的bug。
    IMP (^originalIMPProvider)(void) = ^IMP(void) {
        IMP result = NULL;
        // 如果原本 class 就没人实现那个方法，则返回一个空 block，空 block 虽然没有参数列表，但在业务那边呗转换成 IMP 后就算传多个参数进来也不会 crash
        if (!imp) {
            result = imp_implementationWithBlock(^(id selfObjct) {
                NSLog(@"%@ %@ 没有初始实现，%@\n%@", [NSString stringWithFormat:@"%@", targetClass], NSStringFromSelector(targetSelector), selfObjct, [NSThread callStackSymbols]);
            });
        }else {
            if (hasOverride) {
                result = imp;
            }else {
                Class superclass = class_getSuperclass(targetClass);
                result = class_getMethodImplementation(superclass, targetSelector);
            }
        }
        return result;
    };
    
    if (hasOverride) {
        method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)));
    }else {
        const char *typeEncoding = method_getTypeEncoding(originMethod) ?: [targetClass instanceMethodSignatureForSelector:targetSelector].SILK_typeEncoding;
        class_addMethod(targetClass, targetSelector, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)), typeEncoding);
    }
    return YES;
}

@implementation UITabBar (SILKAdditions)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            // iOS 13 下如果以 UITabBarAppearance 的方式将 UITabBarItem 的 font 大小设置为超过默认的 10，则会出现布局错误，文字被截断，所以这里做了个兼容
            // https://github.com/Tencent/QMUI_iOS/issues/740
            OverrideImplementation(NSClassFromString(@"UITabBarButtonLabel"), @selector(setAttributedText:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
                return ^(UILabel *selfObject, NSAttributedString *firstArgv) {
                    
                    // call super
                    void (*originSelectorIMP)(id, SEL, NSAttributedString *);
                    originSelectorIMP = (void (*)(id, SEL, NSAttributedString *))originalIMPProvider();
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                    
                    CGFloat fontSize = selfObject.font.pointSize;
                    if (fontSize > 10) {
                        [selfObject sizeToFit];
                    }
                };
            });
            
            // iOS 13 下如何设置tabbarItem的字体，tabbarItem的titlePositionAdjustment方法会失效，所以在这里重新设置frame
            OverrideImplementation(NSClassFromString(@"UITabBarButtonLabel"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
                return ^(UILabel *selfObject, CGRect frame) {
                    // call super
                    
                    // 调整位置
                    if (frame.origin.y != 14) {
                        frame.origin.y = 14;
                    }
                    
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                    originSelectorIMP(selfObject, originCMD, frame);
                };
            });
            
            // iOS 13 下如果设置tabbarItem的字体，tabBarItem的imageInsets方法会失效，所以在这里重新设置frame
            OverrideImplementation(NSClassFromString(@"UITabBarSwappableImageView"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
                return ^(UIImageView *selfObject, CGRect frame) {
                    // call super
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originalIMPProvider();
                    originSelectorIMP(selfObject, originCMD, frame);
                };
            });
        }
    });
}

@end

