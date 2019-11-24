//
//  SharesTargetSettingVC.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesTargetSettingVC.h"
#import "UGRemarkView.h"

@interface SharesTargetSettingVC ()

@property(strong, nonatomic) UGRemarkView *titleTF;
@property(strong, nonatomic) UGRemarkView *remarkTV;
@property(strong, nonatomic) UGRemarkView *contentTV;

@property(strong, nonatomic) UIButton *saveBtn;

@end

@implementation SharesTargetSettingVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self configUI];
}
-(void)initData{
    if (!_data) {
        self.data = [SharesTargetData new];
    }
}
-(void)configUI{
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.titleTF = [UGRemarkView new];
    [self.view addSubview:_titleTF];
    _titleTF.titlaLabel.text = @"指标名称";
    
    self.remarkTV = [UGRemarkView new];
    [self.view addSubview:_remarkTV];
    _remarkTV.titlaLabel.text = @"指标描述";
    
    self.contentTV = [UGRemarkView new];
    [self.view addSubview:_contentTV];
    _contentTV.titlaLabel.text = @"指标规则";
    
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn ug_radius:5];
    _saveBtn.backgroundColor = COLORPRIMARY;
    UG_WEAKSELF
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        if ([weakSelf updataData]) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:weakSelf.data];
                [self.view ug_msg:@"baocun"];
            }];
            
        }
    }];
}

-(BOOL)updataData{
    _titleTF.titlaLabel.textColor = COLOR23;
    _remarkTV.titlaLabel.textColor = COLOR23;
    _contentTV.titlaLabel.textColor = COLOR23;
    
    _data.remark = _remarkTV.text;
    _data.cotent = _contentTV.textView.text;
    if (_titleTF.text.length>0) {
        _data.title = _titleTF.text;
    }else{
        _titleTF.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    
    if (_remarkTV.text.length>0) {
        _data.remark = _remarkTV.text;
        
    }else{
        _remarkTV.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    
    if (_contentTV.text.length>0) {
        _data.cotent = _contentTV.text;
        
    }else{
        _contentTV.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    return YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    [_remarkTV mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.titleTF.mas_bottom).mas_offset(KPAND_DEF);
          make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
          make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
          make.height.mas_equalTo(150);
      }];
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.remarkTV.mas_bottom).mas_offset(KPAND_DEF);
          make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
          make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
          make.height.mas_equalTo(250);
      }];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(44);
    }];
}

@end
