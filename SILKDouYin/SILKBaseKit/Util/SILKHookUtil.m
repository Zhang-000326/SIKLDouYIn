//
//  SILKHookUtil.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "SILKHookUtil.h"
#import <objc/runtime.h>

@implementation SILKHookUtil

+ (void)exchangeInstanceMethodForClass:(Class)cls
                      originalSelector:(SEL)originalSelector
                        targetSelector:(SEL)targetSelector {
    [self exchangeMethodForClass:cls
                originalSelector:originalSelector
                  targetSelector:targetSelector
                   isClassMethod:NO];
}

+ (void)exchangeClassMethodForClass:(Class)cls
                   originalSelector:(SEL)originalSelector
                     targetSelector:(SEL)targetSelector {
    [self exchangeMethodForClass:cls
                originalSelector:originalSelector
                  targetSelector:targetSelector
                   isClassMethod:YES];
}

+ (void)exchangeMethodForClass:(Class)cls
              originalSelector:(SEL)originalSelector
                targetSelector:(SEL)targetSelector
                 isClassMethod:(BOOL)isClassMethod{
    Method originalMethod = isClassMethod ? class_getClassMethod(cls, originalSelector) : class_getInstanceMethod(cls, originalSelector);
    Method targetMethod = isClassMethod ? class_getClassMethod(cls, targetSelector): class_getInstanceMethod(cls, targetSelector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    if (didAddMethod) {
       class_replaceMethod(cls, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
       method_exchangeImplementations(originalMethod, targetMethod);
    }
}

+ (void)hockDelegateMethodForClass:(Class)cls
                     delegateClass:(Class)delegateCls
                  originalSelector:(SEL)originalSelector
                       addSelector:(SEL)addSelector
                  exchangeSelector:(SEL)exchangeSelector {
    Method originalMethod = class_getInstanceMethod(delegateCls, originalSelector);
    Method addMethod = class_getInstanceMethod(cls, addSelector);
    Method exchangeMethod = class_getInstanceMethod(cls, exchangeSelector);
    
    // 如果没有实现 delegate 方法，则动态添加
    if (!originalMethod) {
        class_addMethod(delegateCls, originalSelector, method_getImplementation(addMethod), method_getTypeEncoding(addMethod));
        return;
    }
    
    // 判断当前 delegate 方法的实现，是否由 SDK 添加
    IMP originalMethodIMP = method_getImplementation(originalMethod);
    IMP addMethodIMP = method_getImplementation(addMethod);
    IMP exchangeMethodImp = method_getImplementation(exchangeMethod);
    if ((originalMethodIMP == addMethodIMP) || (originalMethodIMP == exchangeMethodImp)) {
        return;
    }
    
    // 向实现 delegate 的类中添加原有方法
    BOOL addOriginalMethod = class_addMethod(delegateCls, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (addOriginalMethod) {
        // 添加成功，说明最开始 get 获取到的是父类的实现，这里重新获取下子类的实现用于交换
        originalMethod = class_getInstanceMethod(delegateCls, originalSelector);
        originalMethodIMP = method_getImplementation(originalMethod);
    }
    
    // 向实现 delegate 的类中添加新的方法
    BOOL addSuccess = class_addMethod(delegateCls, exchangeSelector, method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod));
    if (addSuccess) {
        // 添加成功，获取 delegate 中添加的新方法，并交换方法实现
        Method newMethod = class_getInstanceMethod(delegateCls, exchangeSelector);
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end
