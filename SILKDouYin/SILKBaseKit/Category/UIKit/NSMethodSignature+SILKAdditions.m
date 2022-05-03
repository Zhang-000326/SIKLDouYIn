//
//  NSMethodSignature+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/13.
//

#import "NSMethodSignature+SILKAdditions.h"

#define AYArgumentToString(macro) #macro
#define AYClangWarningConcat(warning_name) AYArgumentToString(clang diagnostic ignored warning_name)

/// 参数可直接传入 clang 的 warning 名，warning 列表参考：https://clang.llvm.org/docs/DiagnosticsReference.html
#define AYBeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(AYClangWarningConcat(#warningName))
#define AYEndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define AYBeginIgnorePerformSelectorLeaksWarning AYBeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define AYEndIgnorePerformSelectorLeaksWarning AYEndIgnoreClangWarning

#define AYBeginIgnoreAvailabilityWarning AYBeginIgnoreClangWarning(-Wpartial-availability)
#define AYEndIgnoreAvailabilityWarning AYEndIgnoreClangWarning

#define AYBeginIgnoreDeprecatedWarning AYBeginIgnoreClangWarning(-Wdeprecated-declarations)
#define AYEndIgnoreDeprecatedWarning AYEndIgnoreClangWarning

@implementation NSMethodSignature (SILKAdditions)


- (NSString *)SILK_typeString {
    AYBeginIgnorePerformSelectorLeaksWarning
    NSString *typeString = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"_%@String", @"type"])];
    AYEndIgnorePerformSelectorLeaksWarning
    return typeString;
}

- (const char *)SILK_typeEncoding {
    return self.SILK_typeString.UTF8String;
}

@end
