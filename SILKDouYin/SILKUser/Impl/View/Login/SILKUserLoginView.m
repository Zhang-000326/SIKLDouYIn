//
//  SILKUserLoginView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import "SILKUserLoginView.h"

#import "SILKUserDefine.h"

@interface SILKUserLoginView ()

@property (nonatomic, weak) id<SILKUserLoginDelegate> delegate;

@property (nonatomic, strong) UITextField *userAccount;
@property (nonatomic, strong) UITextField *userPassword;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation SILKUserLoginView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SILKUserLoginDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = delegate;
        [self setupViews];
    }
    
    return self;
}

- (void)layoutSubviews {
    self.loginBtn.SILK_top = 300;
    self.loginBtn.SILK_centerX = self.SILK_height / 2;
}

- (void)setupViews {
    [self addSubview:self.userAccount];
    [self addSubview:self.userPassword];
    [self addSubview:self.loginBtn];
}

- (void)loginViewShowFinished {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginViewShowFinished)]) {
        [self.delegate loginViewShowFinished];
    }
}

- (UITextField *)userAccount {
    if (!_userAccount) {
        _userAccount = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, 200, 50)];
        _userAccount.borderStyle = UITextBorderStyleRoundedRect;
        _userAccount.placeholder = @"请输入账号";
        _userAccount.font = [UIFont systemFontOfSize:12.f];
        _userAccount.textColor = [UIColor blackColor];
        _userAccount.clearButtonMode = UITextFieldViewModeAlways;
        _userAccount.secureTextEntry = NO;
        _userAccount.textAlignment = NSTextAlignmentCenter;
        _userAccount.keyboardType = UIKeyboardTypeNumberPad;
        _userAccount.returnKeyType = UIReturnKeyDone;
    }
    
    return _userAccount;
}

- (UITextField *)userPassword {
    if (!_userPassword) {
        _userPassword = [[UITextField alloc] initWithFrame:CGRectMake(40, 180, 200, 50)];
        _userPassword.borderStyle = UITextBorderStyleRoundedRect;
        _userPassword.placeholder = @"请输入密码";
        _userPassword.font = [UIFont systemFontOfSize:12.f];
        _userPassword.textColor = [UIColor blackColor];
        _userPassword.clearButtonMode = UITextFieldViewModeAlways;
        _userPassword.secureTextEntry = YES;
        _userPassword.textAlignment = NSTextAlignmentCenter;
        _userPassword.keyboardType = UIKeyboardTypeNumberPad;
        _userPassword.returnKeyType = UIReturnKeyDone;
    }
    
    return _userPassword;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
        _loginBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
        _loginBtn.layer.cornerRadius = _loginBtn.SILK_height / 2.f;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginViewShowFinished) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_loginBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    
    return _loginBtn;
}

@end
