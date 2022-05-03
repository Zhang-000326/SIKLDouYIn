//
//  SILKHookUtil.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKHookUtil : NSObject

+ (void)exchangeInstanceMethodForClass:(Class)cls
                      originalSelector:(SEL)originalSelector
                        targetSelector:(SEL)targetSelector;

+ (void)exchangeClassMethodForClass:(Class)cls
                   originalSelector:(SEL)originalSelector
                     targetSelector:(SEL)targetSelector;

/**
 * 注册代理传入参数
 *
 * @param cls 类
 * @param delegateCls delegate 的类
 * @param originalSelector 原方法
 * @param addSelector 如果 delegate 没有实现对应方法，则添加该方法
 * @param exchangeSelector 如果 delegate 有实现对应方法，则添加该方法后和原方法进行交换
 */
+ (void)hockDelegateMethodForClass:(Class)cls
                     delegateClass:(Class)delegateCls
                  originalSelector:(SEL)originalSelector
                       addSelector:(SEL)addSelector
                  exchangeSelector:(SEL)exchangeSelector;

@end

NS_ASSUME_NONNULL_END
