//
//  SharesAddView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesAddView.h"

@implementation SharesAddView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self ug_radius:5];
    self.backgroundColor = UIColor.whiteColor;
    self.titleLab = [UILabel new];
    [self addSubview:_titleLab];
    _titleLab.text = @"添加测评股票";
    
    
    self.titleTF = [UGRemarkView new];
    [self addSubview:_titleTF];
    _titleTF.titlaLabel.text = @"股票名称";
    
    self.numberTF = [UGRemarkView new];
    [self addSubview:_numberTF];
    _numberTF.titlaLabel.text = @"股票代码";
    
    self.timeTF = [UGRemarkView new];
    [self addSubview:_timeTF];
    _timeTF.titlaLabel.text = @"股票时间";
    
    self.commitBtn = [UIButton new];
    [self addSubview:_commitBtn];
    [_commitBtn setTitle:@"开始测评" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:COLORDANGER];
    [_commitBtn ug_radius:5];
  
}

-(SharesSimpleData *)data{
    
    SharesSimpleData *temdata = [SharesSimpleData new];
    temdata.name = _titleTF.text;
    temdata.number = _numberTF.text;
    temdata.date =  [_timeTF.text intValue];
    return temdata;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self).mas_equalTo(KPAND_DEF);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_equalTo(KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    
    [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self.titleTF.mas_bottom).mas_equalTo(KPAND_MID);
        make.height.mas_equalTo(60);
    }];
    
    [_timeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self.numberTF.mas_bottom).mas_equalTo(KPAND_MID);
        make.height.mas_equalTo(60);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.top.mas_equalTo(self.timeTF.mas_bottom).mas_equalTo(KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
}

@end
