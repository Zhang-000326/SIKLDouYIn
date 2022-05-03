//
//  SILKPhotoManagerProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SILKServiceCenter.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SILKPhotoHandler)(UIImage * _Nullable image, NSData * _Nullable videoData);

@protocol SILKPhotoManager <SILKUniqueService>

@required

/**
 * 弹出相册与摄像机选择页面
 *
 * @param handler 对于选中资源的处理方法
 */
- (void)loadPhotoAlertControllerWithHandler:(SILKPhotoHandler)handler;

/**
 * 弹出相册选择页面
 *
 * @param handler 对于选中资源的处理方法
 */
- (void)loadPhotoAlbumWithHandler:(SILKPhotoHandler)handler;

/**
 * 弹出摄像机拍摄页面
 *
 * @param handler 对于选中资源的处理方法
 */
- (void)loadCameraWithHandler:(SILKPhotoHandler)handler;

@end

NS_ASSUME_NONNULL_END
