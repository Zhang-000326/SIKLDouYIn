//
//  SILKCommerceDefine.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/9.
//

#import "SILKBaseKit.h"

#ifndef SILKCommerceDefine_h
#define SILKCommerceDefine_h

typedef void (^SILKSplashAnimationBlock)(BOOL isNeededAnimation);  ///< 跳转动画

typedef NS_ENUM(NSInteger, SILKSplashComplianceType) {
    SILKSplashComplianceTypeNone = -1,          ///< 填充用
    SILKSplashComplianceTypeButton,             ///< Button 样式
    SILKSplashComplianceTypeSlideUp,            ///< 上滑样式
    SILKSplashComplianceTypeSlideSide,          ///< 侧滑样式
    SILKSplashComplianceTypeGoButton,           ///< GO 样式
    SILKSplashComplianceTypeShake,              ///< 摇一摇样式
    SILKSplashComplianceTypePage,               ///< 翻页
};

#endif /* SILKCommerceDefine_h */
