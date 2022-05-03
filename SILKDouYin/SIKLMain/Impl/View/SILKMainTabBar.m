//
//  SILKMainTabBar.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/12.
//

#import "SILKMainTabBar.h"

#import "SILKMainDefine.h"
#import "SILKMainManager.h"

// customer
#import "SILKFeedManagerProtocol.h"
#import "SILKPhotoManagerProtocol.h"

@interface SILKMainTabBar()

@property (nonatomic, strong) UIButton *addVideoBtn;

@end

@implementation SILKMainTabBar

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.addVideoBtn];
        [self showLine];
    }
    return self;
}

- (void)showLine {
    self.shadowImage = [UIImage SILK_imageWithColor:[UIColor colorWithWhite:1.0f alpha:0.2f] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

- (void)hideLine {
    self.shadowImage = [UIImage SILK_imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 0.5f)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = width / ([[SILKMainManager sharedInstance] currentTabBarItemsNumber] + 1);
    CGFloat btnH = 0;
    
    // add 按钮单独设置，位置居中
    self.addVideoBtn.frame = CGRectMake(0, 0, btnW, 49);
    self.addVideoBtn.center = CGPointMake(width * 0.5f, 49 * 0.5f);
    
    
    NSInteger index = 0;
   
    for (UIControl *button in self.subviews) {
       
        if (![button isKindOfClass:[UIControl class]] || button == self.addVideoBtn) {
            continue;
        }
        
        // 计算btnX，
        btnX = btnW * (index > 1 ? index+1 : index);
        // 这里高度不能设置为tabbar的高度，因为iOS11 tabbar高度变化了
        btnH = button.frame.size.height;
        
        // 设置frame
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 增加索引
        index++;
    }
}

- (void)loadImagePickerController {
    SILKPhotoHandler photoHandler = ^void(UIImage * _Nullable image, NSData * _Nullable videoData) {
        [GET_INSTANCE_FROM_PROTOCOL(SILKFeedManager) saveVideoData:videoData];
    };
    
    [GET_INSTANCE_FROM_PROTOCOL(SILKPhotoManager) loadPhotoAlertControllerWithHandler:photoHandler];
}

#pragma mark - 懒加载
- (UIButton *)addVideoBtn {
    if (!_addVideoBtn) {
        _addVideoBtn = [UIButton new];
        [_addVideoBtn setImage:[UIImage imageNamed:@"main_add_video"] forState:UIControlStateNormal];
        [_addVideoBtn addTarget:self action:@selector(loadImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addVideoBtn;
}
@end

