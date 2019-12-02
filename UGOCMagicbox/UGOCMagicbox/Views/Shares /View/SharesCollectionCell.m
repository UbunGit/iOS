//
//  SharesCollectionCell.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesCollectionCell.h"


@implementation ToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self ug_radius:22];
    self.upBtn = [UIButton new];
    [self addSubview:_upBtn];
    [_upBtn setTitle:@"看涨" forState:UIControlStateNormal];
    [_upBtn setBackgroundColor:UIColor.redColor];
    
    self.downBtn = [UIButton new];
    [self addSubview:_downBtn];
    [_downBtn setTitle:@"看跌" forState:UIControlStateNormal];
    [_downBtn setBackgroundColor:UIColor.greenColor];
    
    self.igoBtn = [UIButton new];
    [self addSubview:_igoBtn];
    [_igoBtn setTitle:@"看平" forState:UIControlStateNormal];
    [_igoBtn setBackgroundColor:UIColor.blueColor];
}

-(void)layoutSubviews{
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [_igoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.upBtn.mas_right);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.upBtn);
    }];
    [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.igoBtn.mas_right);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.igoBtn);
    }];
}
@end

@implementation SharesCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.toolView = [ToolView new];
    [self.contentView addSubview:_toolView];
    
    self.titleLab = [UILabel new];
    [self.contentView addSubview:_titleLab];
    _titleLab.font = FONT_SYS20;
    _titleLab.textColor = COLOR23;
    _titleLab.numberOfLines = 0;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    
    self.numberLab= [UILabel new];
    [self.contentView addSubview:_numberLab];
    _numberLab.font = FONT_SYS12;
    _numberLab.textColor = COLOR23;
    _numberLab.textAlignment = NSTextAlignmentCenter;
    
    
    self.valueLab = [UILabel new];
    [self.contentView addSubview:_valueLab];
    _valueLab.font = [UIFont systemFontOfSize:26];
    _valueLab.textAlignment = NSTextAlignmentCenter;
    _valueLab.textColor = UIColor.whiteColor;
    _valueLab.backgroundColor = COLORDANGER;
    _valueLab.text = @"未评分";
    [_valueLab ug_radius:60];
    
}


-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self.contentView).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);

    }];
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLab.mas_top).mas_equalTo(-100);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        
    }];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_equalTo(100);
        make.left.mas_equalTo(self.contentView).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        make.height.mas_equalTo(44);
    }];
    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        
    }];
}
@end
