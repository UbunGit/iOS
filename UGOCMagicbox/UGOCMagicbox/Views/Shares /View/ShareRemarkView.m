//
//  ShareRemarkView.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/4.
//  Copyright © 2019 UG. All rights reserved.
//

#import "ShareRemarkView.h"

@implementation RemarkViewValue



@end
/**
 添加测评意见view
 */
@implementation ShareRemarkView

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
    _titleLab.text = @"添加测评意见";
    
    self.priceinTF = [UGRemarkView new];
    [self addSubview:_priceinTF];
    _priceinTF.titlaLabel.text = @"建议买入价";
    
    self.priceoutTF = [UGRemarkView new];
    [self addSubview:_priceoutTF];
    _priceoutTF.titlaLabel.text = @"预估卖出价";
    
    self.timeTF = [UGRemarkView new];
    [self addSubview:_timeTF];
    _timeTF.titlaLabel.text = @"预估操作时间";
    
    self.remarkTF = [UGRemarkView new];
    [self addSubview:_remarkTF];
    _remarkTF.titlaLabel.text = @"测评意见";
    
    self.commitBtn = [UIButton new];
    [self addSubview:_commitBtn];
    [_commitBtn setTitle:@"确认并保存" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:COLORDANGER];
    [_commitBtn ug_radius:5];
  
}

-(RemarkViewValue *)value{
    RemarkViewValue *data = [RemarkViewValue new];
    data.pricein = [_priceinTF.text floatValue];
    data.priceout = [_priceoutTF.text floatValue];
    data.handletime = [_timeTF.text intValue];
    data.remark = _remarkTF.text;
    return  data;
}

-(void)reload:(RemarkViewValue *)info{
    _priceinTF.text = [NSString stringWithFormat:@"%.2f",info.pricein];
    _priceoutTF.text = [NSString stringWithFormat:@"%.2f",info.priceout];
    _timeTF.text = [NSString stringWithFormat:@"%f",info.handletime];
    _remarkTF.text = info.remark;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self).mas_equalTo(KPAND_DEF);
    }];
    
    [_priceinTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_equalTo(KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    
    [_priceoutTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self.priceinTF.mas_bottom).mas_equalTo(KPAND_MID);
        make.height.mas_equalTo(60);
    }];
    
    [_timeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self.priceoutTF.mas_bottom).mas_equalTo(KPAND_MID);
        make.height.mas_equalTo(60);
    }];
    [_remarkTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_MID);
        make.top.mas_equalTo(self.timeTF.mas_bottom).mas_equalTo(KPAND_MID);
        make.height.mas_equalTo(120);
    }];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
        make.top.mas_equalTo(self.remarkTF.mas_bottom).mas_equalTo(KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
}

@end
