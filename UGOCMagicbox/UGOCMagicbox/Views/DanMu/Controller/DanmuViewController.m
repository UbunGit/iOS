//
//  DanmuViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DanmuViewController.h"

#import "PersentViewController.h"
#import "DamuSendView.h"
#import "DanMushowView.h"



@interface DanmuViewController ()
@property(strong, nonatomic) UIButton *sendBtn;
@property(strong, nonatomic) PersentViewController *persent;
@property (nonatomic, strong) DamuSendView *damuSendView;
@property (nonatomic, strong) DanMushowView *danMushowView;
@end

@implementation DanmuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.sendBtn = [UIButton new];
    [_sendBtn setTitle:@"发送弹幕" forState:UIControlStateNormal];
    [_sendBtn setBackgroundColor:COLORDANGER];
    [_sendBtn ug_radius:5];
    [self.view addSubview:_sendBtn];
    UG_WEAKSELF
    [_sendBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
   
        weakSelf.persent.cotentView = self.damuSendView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    }];
    
    self.danMushowView = [DanMushowView new];
    [self.view addSubview:_danMushowView];
    
  
}
-(PersentViewController *)persent{
    
    if (!_persent) {
        _persent = [PersentViewController new];
        _persent.type = 1;
    }
    return _persent;
}
-(DamuSendView *)damuSendView{
    if (!_damuSendView) {
        _damuSendView = [DamuSendView new];
        [_damuSendView.inputView.sendBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            NSString *str = [_damuSendView.inputView.textField.text copy];
            [self.danMushowView.listarr insertObject:str atIndex:0];
            DDLogVerbose(@"instre:%@",self.danMushowView.listarr);
        }];
    }
    return _damuSendView;
}



-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self.view).mas_equalTo(-KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
    
    [_danMushowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoAcale(100));
        make.top.mas_equalTo(self.view).mas_offset(KPAND_DEF);
    }];
    

}
@end
