//
//  SILKWebViewController.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SILKWebViewDelegate <NSObject>

- (void)removeWebView;

@end

@interface SILKWebViewController : UIViewController

@property (nonatomic, weak) id<SILKWebViewDelegate> delegate;

- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
