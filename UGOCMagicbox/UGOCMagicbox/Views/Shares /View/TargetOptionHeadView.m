//
//  TargetOptionHeadView.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/1.
//  Copyright © 2019 UG. All rights reserved.
//

#import "TargetOptionHeadView.h"

@implementation TargetOptionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self ug_radius:5];
    self.backgroundColor = UIColor.whiteColor;
    
    self.remarkLab = [UILabel new];
    [self addSubview:_remarkLab];
    _remarkLab.text = @"添加可选值（可选值为空则默认为无）";
    [self addSubview:_remarkLab];
    
    self.addBtn = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [self addSubview:_addBtn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KPAND_DEF);
        make.centerY.mas_equalTo(self);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KPAND_DEF);
        make.centerY.mas_equalTo(self);
    }];
}
@end
