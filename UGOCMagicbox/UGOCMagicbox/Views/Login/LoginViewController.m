//
//  LoginViewController.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/26.
//  Copyright © 2019 UG. All rights reserved.
//

#import "LoginViewController.h"

#import "UGRemarkView.h"
#import "UIAppdelegate+Realm.h"

@interface LoginViewController ()

@property(strong, nonatomic) UGRemarkView *usernameTF; // 用户名

@property(strong, nonatomic) UGRemarkView *passwordTF; // 密码

@property(strong, nonatomic) UIButton *commitBtn; // 登陆

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.usernameTF = [UGRemarkView new];
    [self.view addSubview:_usernameTF];
    _usernameTF.titlaLabel.text = @"用户名";
    _usernameTF.textView.text = @"UbunGit";
    
    self.passwordTF = [UGRemarkView new];
    [self.view addSubview:_passwordTF];
    _passwordTF.titlaLabel.text = @"密码";
    _passwordTF.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"LPASSWORD"];
    
  
    self.commitBtn = [UIButton new];
    [self.view addSubview:_commitBtn];
    [_commitBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:COLORDANGER];
    [_commitBtn ug_radius:5];
    UG_WEAKSELF
    [_commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [[NSUserDefaults standardUserDefaults]setObject:weakSelf.passwordTF.text forKey:@"LPASSWORD"];
        [[NetWorkRequest share].afManager.requestSerializer setAuthorizationHeaderFieldWithUsername:weakSelf.usernameTF.text password:weakSelf.passwordTF.text];
        [[UIApplication sharedApplication] updateRealInfo];
    }];
  
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_usernameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.passwordTF.mas_top).mas_offset(-KPAND_MID);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).mas_offset(KPAND_MID);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
}

@end
