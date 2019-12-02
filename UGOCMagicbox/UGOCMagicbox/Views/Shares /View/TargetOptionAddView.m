//
//  TargetOptionAddView.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/12/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import "TargetOptionAddView.h"

@implementation TargetOptionAddView

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
    _titleLab.text = @"添加选项";
    
    self.titleTF = [UGRemarkView new];
    [self addSubview:_titleTF];
    _titleTF.titlaLabel.text = @"选项名称";
    
    self.remarkTV = [UGRemarkView new];
    [self addSubview:_remarkTV];
    _remarkTV.titlaLabel.text = @"选项描述";
    
    self.valueTV = [UGRemarkView new];
    [self addSubview:_valueTV];
    _valueTV.titlaLabel.text = @"选项分值";
    
    self.commitBtn = [UIButton new];
    [self addSubview:_commitBtn];
    [_commitBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:COLORDANGER];
    [_commitBtn ug_radius:5];
}


-(void)setEditData:(SharesTargetOption *)editData{
    _editData = editData;
    if (!_editData) {
        _editData = [SharesTargetOption new];
        _editData.key = [_editData makeKey];
    }
    _titleTF.text = _editData.title;
    _remarkTV.text = _editData.remark;
    _valueTV.text = _editData.value;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
         make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
         make.top.mas_equalTo(self).mas_equalTo(KPAND_DEF);
     }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    
    [_remarkTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTF.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    
    [_valueTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remarkTV.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.top.mas_equalTo(self.valueTV.mas_bottom).mas_equalTo(KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
}
@end
