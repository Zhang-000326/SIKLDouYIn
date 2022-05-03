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
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.view addSubview:wkWebView];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClicked:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = NO;
}

- (void)buttonClicked:(UIBarButtonItem *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
