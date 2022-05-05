//
//  SILKWebViewController.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKWebViewController.h"

#import "SILKCommerceDefine.h"

#import <WebKit/WebKit.h>

@interface SILKWebViewController ()

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) UIView *bannerView;

@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation SILKWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVBAR_HEIGHT)];
    self.bannerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bannerView];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, STATUSBAR_HEIGHT, 70, NAVBAR_HEIGHT - STATUSBAR_HEIGHT)];
    
    self.backBtn.backgroundColor = [UIColor whiteColor];
    self.backBtn.layer.cornerRadius = self.backBtn.SILK_height / 2.f;
    self.backBtn.layer.masksToBounds = YES;
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightBold];

    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor SILK_colorWithHexString:@"#23a1e0" alpha:0.5] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.backBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.bannerView addSubview:self.backBtn];
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT)];
    
    [self.view addSubview:wkWebView];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)buttonClicked:(UIBarButtonItem *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeWebView)]) {
        [self.delegate removeWebView];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDarkContent;
}

@end
