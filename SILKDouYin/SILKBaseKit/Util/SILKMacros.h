//
//  SILKMacros.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>

#import "UIDevice+SILKAdditions.h"

#ifndef SILKMacros_h
#define SILKMacros_h

// 屏幕宽高
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

// 导航栏高度与tabbar高度
#define NAVBAR_HEIGHT       (IS_iPhoneX ? 88.0f : 64.0f)
#define TABBAR_HEIGHT       (IS_iPhoneX ? 83.0f : 49.0f)

// 状态栏高度
#define STATUSBAR_HEIGHT    (IS_iPhoneX ? 44.0f : 20.0f)

// 安全区域（不包含状态栏）
#define SAFE_TOP            (IS_iPhoneX ? 24.0f : 0.0f)
#define SAFE_BTM            (IS_iPhoneX ? 34.0f : 0.0f)

// 判断是否是iPhone X系列
#define IS_iPhoneX          [UIDevice SILK_isIPhoneXSeries]


// 容器判空
#ifndef SILK_isEmptyString
FOUNDATION_EXPORT BOOL SILK_isEmptyString(id param);
#endif

#ifndef SILK_isEmptyArray
FOUNDATION_EXPORT BOOL SILK_isEmptyArray(id param);
#endif

#ifndef SILK_isEmptyDictionary
FOUNDATION_EXPORT BOOL SILK_isEmptyDictionary(id param);
#endif

#endif /* SILKMacros_h */
