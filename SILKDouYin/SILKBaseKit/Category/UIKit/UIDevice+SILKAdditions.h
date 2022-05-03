//
//  UIDevice+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * These string values are defined for +[UIDevice SILK_platformString]'s return value.
 *
 */
#define IPHONE_1G_NAMESTRING            @"iPhone 1G"
#define IPHONE_3G_NAMESTRING            @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING           @"iPhone 3GS"
#define IPHONE_4_NAMESTRING             @"iPhone 4"
#define IPHONE_4S_NAMESTRING            @"iPhone 4S"
#define IPHONE_5GSM_NAMESTRING          @"iPhone 5 (GSM)"
#define IPHONE_5Global_NAMESTRING       @"iPhone 5 (Global)"
#define IPHONE_5C_NAMESTRING            @"iPhone 5C"
#define IPHONE_5S_NAMESTRING            @"iPhone 5S"
#define IPHONE_6_NAMESTRING             @"iPhone 6"
#define IPHONE_6_PLUS_NAMESTRING        @"iPhone 6 Plus"
#define IPHONE_6S_NAMESTRING            @"iPhone 6S"
#define IPHONE_6S_PLUS_NAMESTRING       @"iPhone 6S Plus"
#define IPHONE_SE_NAMESTRING            @"iPhone SE"
#define IPHONE_7_NAMESTRING             @"iPhone 7"
#define IPHONE_7_PLUS_NAMESTRING        @"iPhone 7 Plus"
#define IPHONE_8_NAMESTRING             @"iPhone 8"
#define IPHONE_8_PLUS_NAMESTRING        @"iPhone 8 Plus"
#define IPHONE_X_NAMESTRING             @"iPhone X"
#define IPHONE_XS_NAMESTRING            @"iPhone XS"
#define IPHONE_XS_MAX_NAMESTRING        @"iPhone XS Max"
#define IPHONE_XR_NAMESTRING            @"iPhone XR"
#define IPHONE_11_NAMESTRING            @"iPhone 11"
#define IPHONE_11_PRO_NAMESTRING        @"iPhone 11 Pro"
#define IPHONE_11_PRO_MAX_NAMESTRING    @"iPhone 11 Pro Max"
#define IPHONE_12_MINI_NAMESTRING       @"iPhone 12 mini"
#define IPHONE_12_NAMESTRING            @"iPhone 12"
#define IPHONE_12_PRO_NAMESTRING        @"iPhone 12 Pro"
#define IPHONE_12_PRO_MAX_NAMESTRING    @"iPhone 12 Pro Max"
#define IPHONE_SE_2_NAMESTRING          @"iPhone SE2"
#define IPHONE_13_MINI_NAMESTRING       @"iPhone 13 mini"
#define IPHONE_13_NAMESTRING            @"iPhone 13"
#define IPHONE_13_PRO_NAMESTRING        @"iPhone 13 Pro"
#define IPHONE_13_PRO_MAX_NAMESTRING    @"iPhone 13 Pro Max"

#define IPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define IPHONE_SIMULATOR_NAMESTRING         @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING  @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING    @"iPad Simulator"

typedef NS_ENUM(NSInteger, UIDevicePlatform) {
    UIDeviceUnknown,
    
    UIDeviceiPhoneSimulator,
    UIDeviceiPhoneSimulatoriPhone,
    UIDeviceiPhoneSimulatoriPad,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4siPhone,
    UIDevice5GSMiPhone,
    UIDevice5GlobaliPhone,
    UIDevice5CiPhone,
    UIDevice5SiPhone,
    UIDevice6iPhone,
    UIDevice6PlusiPhone,
    UIDevice6SiPhone,
    UIDevice6SPlusiPhone,
    UIDeviceSEiPhone,
    UIDevice7_1iPhone,
    UIDevice7_3iPhone,
    UIDevice7_2PlusiPhone,
    UIDevice7_4PlusiPhone,
    UIDevice8iPhone,
    UIDevice8PlusiPhone,
    UIDeviceXiPhone,
    UIDeviceXSiPhone,
    UIDeviceXSMaxiPhone,
    UIDeviceXRiPhone,
    UIDevice11iPhone,
    UIDevice11ProiPhone,
    UIDevice11ProMaxiPhone,
    UIDevice12MiniiPhone,
    UIDevice12iPhone,
    UIDevice12ProiPhone,
    UIDevice12ProMaxiPhone,
    UIDeviceSE2iPhone,
    UIDevice13MiniiPhone,
    UIDevice13iPhone,
    UIDevice13ProiPhone,
    UIDevice13ProMaxiPhone,
};

@interface UIDevice (SILKAdditions)

/**
 *
 * @return hw.machine info. (e.g. @"iPhone1,1", @"iPhone13,4",  ...).
 */
+ (nullable NSString *)SILK_platform;

+ (UIDevicePlatform)SILK_platformType;

/**
 *
 * @return the currentDevice's name string(e.g. @"iPhone 12 Pro Max", @"iPhone Simulator"...). The name string has been defined above(e.g. IPHONE_12_PRO_NAMESTRING, ...).
 */
+ (nullable NSString *)SILK_platformString;

/**
 * return YES if the device has a notch screen.(iPhone X, iPhone 11 and more)
 *
 * @return bool
 */
+ (BOOL)SILK_isIPhoneXSeries;

@end

NS_ASSUME_NONNULL_END
