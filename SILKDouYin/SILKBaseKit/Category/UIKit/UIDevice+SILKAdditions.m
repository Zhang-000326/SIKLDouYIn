//
//  UIDevice+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import "UIDevice+SILKAdditions.h"

#import "UIWindow+SILKAdditions.h"

#import <sys/sysctl.h>
#import <sys/utsname.h>

@implementation UIDevice (SILKAdditions)

#pragma mark - Public Method

+ (NSString *)SILK_platform {
    return [self getSysInfoByName:"hw.machine"];
}

+ (UIDevicePlatform)SILK_platformType {
    NSString *platform = [self SILK_platform];
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])        return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])        return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])                return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])                return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])                return UIDevice4siPhone;
    if ([platform isEqualToString:@"iPhone5,1"])        return UIDevice5GSMiPhone;
    if ([platform isEqualToString:@"iPhone5,2"])        return UIDevice5GlobaliPhone;
    if ([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"])
                                                        return UIDevice5CiPhone;
    if ([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"])
                                                        return UIDevice5SiPhone;
    if ([platform isEqualToString:@"iPhone7,1"])        return UIDevice6PlusiPhone;
    if ([platform isEqualToString:@"iPhone7,2"])        return UIDevice6iPhone;
    if ([platform isEqualToString:@"iPhone8,1"])        return UIDevice6SiPhone;
    if ([platform isEqualToString:@"iPhone8,2"])        return UIDevice6SPlusiPhone;
    if ([platform isEqualToString:@"iPhone8,4"])        return UIDeviceSEiPhone;
    if ([platform isEqualToString:@"iPhone9,1"])        return UIDevice7_1iPhone;
    if ([platform isEqualToString:@"iPhone9,3"])        return UIDevice7_3iPhone;
    if ([platform isEqualToString:@"iPhone9,2"])        return UIDevice7_2PlusiPhone;
    if ([platform isEqualToString:@"iPhone9,4"])        return UIDevice7_4PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,1"])       return UIDevice8iPhone;
    if ([platform isEqualToString:@"iPhone10,4"])       return UIDevice8iPhone;
    if ([platform isEqualToString:@"iPhone10,2"])       return UIDevice8PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,5"])       return UIDevice8PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,3"])       return UIDeviceXiPhone;
    if ([platform isEqualToString:@"iPhone10,6"])       return UIDeviceXiPhone;
    if ([platform isEqualToString:@"iPhone11,2"])       return UIDeviceXSiPhone;
    if ([platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"])
                                                        return UIDeviceXSMaxiPhone;
    if ([platform isEqualToString:@"iPhone11,8"])       return UIDeviceXRiPhone;
    if ([platform isEqualToString:@"iPhone12,1"])       return UIDevice11iPhone;
    if ([platform isEqualToString:@"iPhone12,3"])       return UIDevice11ProiPhone;
    if ([platform isEqualToString:@"iPhone12,5"])       return UIDevice11ProMaxiPhone;
    if ([platform isEqualToString:@"iPhone13,1"])       return UIDevice12MiniiPhone;
    if ([platform isEqualToString:@"iPhone13,2"])       return UIDevice12iPhone;
    if ([platform isEqualToString:@"iPhone13,3"])       return UIDevice12ProiPhone;
    if ([platform isEqualToString:@"iPhone13,4"])       return UIDevice12ProMaxiPhone;
    if ([platform isEqualToString:@"iPhone12,8"])       return UIDeviceSE2iPhone;
    if ([platform isEqualToString:@"iPhone14,4"])       return UIDevice13MiniiPhone;
    if ([platform isEqualToString:@"iPhone14,5"])       return UIDevice13iPhone;
    if ([platform isEqualToString:@"iPhone14,2"])       return UIDevice13ProiPhone;
    if ([platform isEqualToString:@"iPhone14,3"])       return UIDevice13ProMaxiPhone;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceiPhoneSimulatoriPhone : UIDeviceiPhoneSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

+ (NSString *)SILK_platformString {
    switch ([self SILK_platformType]) {
        case UIDevice1GiPhone:                  return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone:                  return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone:                 return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone:                   return IPHONE_4_NAMESTRING;
        case UIDevice4siPhone:                  return IPHONE_4S_NAMESTRING;
        case UIDevice5GSMiPhone:                return IPHONE_5GSM_NAMESTRING;
        case UIDevice5GlobaliPhone:             return IPHONE_5Global_NAMESTRING;
        case UIDevice5CiPhone:                  return IPHONE_5C_NAMESTRING;
        case UIDevice5SiPhone:                  return IPHONE_5S_NAMESTRING;
        case UIDevice6iPhone:                   return IPHONE_6_NAMESTRING;
        case UIDevice6PlusiPhone:               return IPHONE_6_PLUS_NAMESTRING;
        case UIDevice6SiPhone:                  return IPHONE_6S_NAMESTRING;
        case UIDevice6SPlusiPhone:              return IPHONE_6S_PLUS_NAMESTRING;
        case UIDeviceSEiPhone:                  return IPHONE_SE_NAMESTRING;
        case UIDevice7_1iPhone:                 return IPHONE_7_NAMESTRING;
        case UIDevice7_3iPhone:                 return IPHONE_7_NAMESTRING;
        case UIDevice7_2PlusiPhone:             return IPHONE_7_PLUS_NAMESTRING;
        case UIDevice7_4PlusiPhone:             return IPHONE_7_PLUS_NAMESTRING;
        case UIDevice8iPhone:                   return IPHONE_8_NAMESTRING;
        case UIDevice8PlusiPhone:               return IPHONE_8_PLUS_NAMESTRING;
        case UIDeviceXiPhone:                   return IPHONE_X_NAMESTRING;
        case UIDeviceXSiPhone:                  return IPHONE_XS_NAMESTRING;
        case UIDeviceXSMaxiPhone:               return IPHONE_XS_MAX_NAMESTRING;
        case UIDeviceXRiPhone:                  return IPHONE_XR_NAMESTRING;
        case UIDevice11iPhone:                  return IPHONE_11_NAMESTRING;
        case UIDevice11ProiPhone:               return IPHONE_11_PRO_NAMESTRING;
        case UIDevice11ProMaxiPhone:            return IPHONE_11_PRO_MAX_NAMESTRING;
        case UIDevice12MiniiPhone:              return IPHONE_12_MINI_NAMESTRING;
        case UIDevice12iPhone:                  return IPHONE_12_NAMESTRING;
        case UIDevice12ProiPhone:               return IPHONE_12_PRO_NAMESTRING;
        case UIDevice12ProMaxiPhone:            return IPHONE_12_PRO_MAX_NAMESTRING;
        case UIDeviceSE2iPhone:                 return IPHONE_SE_2_NAMESTRING;
        case UIDevice13MiniiPhone:              return IPHONE_13_MINI_NAMESTRING;
        case UIDevice13iPhone:                  return IPHONE_13_NAMESTRING;
        case UIDevice13ProiPhone:               return IPHONE_13_PRO_NAMESTRING;
        case UIDevice13ProMaxiPhone:            return IPHONE_13_PRO_MAX_NAMESTRING;
            
        case UIDeviceiPhoneSimulator:           return IPHONE_SIMULATOR_NAMESTRING;
        case UIDeviceiPhoneSimulatoriPhone:     return IPHONE_SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceiPhoneSimulatoriPad:       return IPHONE_SIMULATOR_IPAD_NAMESTRING;
        
        default: return [self SILK_platform];
    }
}

+ (BOOL)SILK_isIPhoneXSeries {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iPhoneXSeriesLock = dispatch_semaphore_create(1);
        executedTokenLock = dispatch_semaphore_create(1);
    });
    if (![self _executedToken]) {
        if ([self _isIPhoneXSeriesForTheRealPhone] || [self _isIPhoneXSeriesForSimulator] ||
            ([[UIDevice currentDevice].model isEqualToString: @"iPhone"] && [self SILK_isScreenHeightLarge736])) {
            [self _setIPhoneXSeries:YES];
        }
        [self _setExecutedToken:YES];
    }
    return [self _iPhoneXSeries];
}

#pragma mark - Private Method

+ (BOOL)SILK_isScreenHeightLarge736 {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat len = MAX(size.height, size.width);
    return (int)len > 736;
}

+ (NSString *)getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    if (answer == NULL) return nil;
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

static BOOL iPhoneXSeries = NO;
static dispatch_semaphore_t iPhoneXSeriesLock;

+ (BOOL)_iPhoneXSeries {
    BOOL result = NO;
    dispatch_semaphore_wait(iPhoneXSeriesLock, DISPATCH_TIME_FOREVER);
    result = iPhoneXSeries;
    dispatch_semaphore_signal(iPhoneXSeriesLock);
    return result;
}

+ (void)_setIPhoneXSeries:(BOOL)_iPhoneXSeries {
    dispatch_semaphore_wait(iPhoneXSeriesLock, DISPATCH_TIME_FOREVER);
    iPhoneXSeries = _iPhoneXSeries;
    dispatch_semaphore_signal(iPhoneXSeriesLock);
}

static BOOL executedToken = NO;
static dispatch_semaphore_t executedTokenLock;

+ (BOOL)_executedToken {
    BOOL result = NO;
    dispatch_semaphore_wait(executedTokenLock, DISPATCH_TIME_FOREVER);
    result = executedToken;
    dispatch_semaphore_signal(executedTokenLock);
    return result;
}

+ (void)_setExecutedToken:(BOOL)_executedToken {
    dispatch_semaphore_wait(executedTokenLock, DISPATCH_TIME_FOREVER);
    executedToken = _executedToken;
    dispatch_semaphore_signal(executedTokenLock);
}

+ (BOOL)_isIPhoneXSeriesForTheRealPhone{
    BOOL iPhoneXSeries = NO;
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"] || [platform isEqualToString:@"iPhone11,8"] || [platform isEqualToString:@"iPhone11,2"] || [platform isEqualToString:@"iPhone11,4"] || [platform isEqualToString:@"iPhone11,6"] || [platform isEqualToString:@"iPhone12,1"] || [platform isEqualToString:@"iPhone12,3"] || [platform isEqualToString:@"iPhone12,5"] || [platform isEqualToString:@"iPhone13,1"] || [platform isEqualToString:@"iPhone13,2"] || [platform isEqualToString:@"iPhone13,3"] || [platform isEqualToString:@"iPhone13,4"] || [platform isEqualToString:@"iPhone14,4"] || [platform isEqualToString:@"iPhone14,5"] || [platform isEqualToString:@"iPhone14,2"] || [platform isEqualToString:@"iPhone14,3"]) {
        iPhoneXSeries = YES;
    }
    return iPhoneXSeries;
}

+ (BOOL)_isIPhoneXSeriesForSimulator{
    __block BOOL iPhoneXSeries = NO;
    if ([[UIDevice currentDevice].model isEqualToString: @"iPhone"]) {
        if (@available(iOS 11.0, *)) {
            if ([NSThread isMainThread]) {
                UIWindow *window = [UIDevice SILK_mainWindow];
                if (window.safeAreaInsets.bottom > 0.0) {
                    iPhoneXSeries = YES;
                }
                return iPhoneXSeries;
            }
            else{
                dispatch_semaphore_t sem = dispatch_semaphore_create(0);
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIWindow *window = [UIDevice SILK_mainWindow];
                    if (window.safeAreaInsets.bottom > 0.0) {
                        iPhoneXSeries = YES;
                    }
                    dispatch_semaphore_signal(sem);
                });
                dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
                return iPhoneXSeries;
            }
        }
    }
    return iPhoneXSeries;
}

+ (UIWindow *)SILK_mainWindow {
    UIWindow * window = nil;
    
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    
    if (![window isKindOfClass:[UIView class]]) {
        window = [UIWindow SILK_keyWindow];
    }
    
    if (!window) {
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    
    return window;
}

@end
