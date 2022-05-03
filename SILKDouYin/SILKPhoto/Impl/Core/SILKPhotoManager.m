//
//  SILKPhotoManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/13.
//

#import "SILKPhotoManager.h"

// header
#import "SILKMainDefine.h"

// model
#import "SILKVideoModel.h"

// view
#import "SILKMainTabBarController.h"

// photo
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "SILKMainManagerProtocol.h"

@interface SILKPhotoManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) SILKPhotoHandler handler;

@end

@implementation SILKPhotoManager

- (instancetype)initPrivate {
    self = [super init];
    if (self) {

    }
    
    return self;
}

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKPhotoManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKPhotoManager alloc] initPrivate];
    });
    return instance;
}

- (void)loadPhotoAlertControllerWithHandler:(SILKPhotoHandler)handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择上传方式" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SILKPhotoManager sharedInstance] loadPhotoAlbumWithHandler:handler];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"手动拍摄添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SILKPhotoManager sharedInstance] loadCameraWithHandler:handler];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [(UIViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKMainManager) mainTabBarController] presentViewController:alert animated:YES completion:nil];
}

- (void)loadPhotoAlbumWithHandler:(SILKPhotoHandler)handler {
    if (handler) {
        self.handler = handler;
    }
    
    //本地相册不需要检查，因为UIImagePickerController会自动检查并提醒
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    // 设置相册
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 手机选择一段视频或一张图片
    // kUTTypeMovie: 视频
    // kUTTypeImage: 图片
    pickerController.mediaTypes =@[(NSString*)kUTTypeMovie, (NSString*)kUTTypeImage];
    // 签协议
    pickerController.delegate = self;
    // 添加相册界面
    [(UIViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKMainManager) mainTabBarController] presentViewController:pickerController animated:YES completion:nil];
}

- (void)loadCameraWithHandler:(SILKPhotoHandler)handler {
    if (handler) {
        self.handler = handler;
    }
    
    //本地相册不需要检查，因为UIImagePickerController会自动检查并提醒
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    // 设置摄像机
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 手机选择一段视频或一张图片
    // kUTTypeMovie: 视频
    // kUTTypeImage: 图片
    pickerController.mediaTypes =@[(NSString*)kUTTypeMovie, (NSString*)kUTTypeImage];
    // 设置后摄像头
    pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    // 设置最长拍摄时间
    pickerController.videoMaximumDuration = 15.f;
    // 设置拍摄质量
    pickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    // 签协议
    pickerController.delegate = self;
    // 添加相册界面
    [(UIViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKMainManager) mainTabBarController] presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 移除相册界面
    [(UIViewController *)[GET_INSTANCE_FROM_PROTOCOL(SILKMainManager) mainTabBarController] dismissViewControllerAnimated:YES completion:nil];
    
    // 获取文件类型:
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
         // 用户选的文件为图片类型(kUTTypeImage)
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.handler) {
            self.handler(image, nil);
        }
    }else if([mediaType isEqualToString:(NSString*)kUTTypeMovie]){
        // 用户选的文件为视频类型(kUTTypeMovie)
        // 获取视频对应的URL
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        // 存储视频 data
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (self.handler) {
            self.handler(nil, data);
        }
    }
}

@end
