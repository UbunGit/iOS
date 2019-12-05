//
//  SharesToolView.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/5.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesToolView.h"

@implementation SharesToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.backgroundColor = UIColor.clearColor;
    self.addtargetbtn = [UGAlignmentButton new];
    [self addSubview:_addtargetbtn];
    [_addtargetbtn setTitle:@"指标" forState:UIControlStateNormal];
    UIImage *addimage = [UIImage imageWithIcon:@"fa-filter" backgroundColor:UIColor.clearColor iconColor:COLORDANGER andSize:CGSizeMake(22, 22)];
    [_addtargetbtn setImage:addimage forState:UIControlStateNormal];
    [_addtargetbtn ug_radius:30];
    [_addtargetbtn ug_borderColor:UIColor.whiteColor width:1];
    [_addtargetbtn setUg_Alignment: UGAlignmentBottom];
    _addtargetbtn.titleLabel.font = FONT_SYS12;
    
    self.gitupbtn = [UGAlignmentButton new];
    [self addSubview:_gitupbtn];
    [_gitupbtn setTitle:@"上传" forState:UIControlStateNormal];
    UIImage *gitupimage = [UIImage imageWithIcon:@"fa-cloud-upload" backgroundColor:UIColor.clearColor iconColor:COLORDANGER andSize:CGSizeMake(22, 22)];
    [_gitupbtn setImage:gitupimage forState:UIControlStateNormal];
    [_gitupbtn ug_radius:30];
     [_gitupbtn ug_borderColor:UIColor.whiteColor width:1];
     [_gitupbtn setUg_Alignment: UGAlignmentBottom];
    _gitupbtn.titleLabel.font = FONT_SYS12;
    
    self.gitdownbtn = [UGAlignmentButton new];
    [self addSubview:_gitdownbtn];
    [_gitdownbtn setTitle:@"下载" forState:UIControlStateNormal];
    UIImage *gitdownimage = [UIImage imageWithIcon:@"fa-cloud-download" backgroundColor:UIColor.clearColor iconColor:COLORDANGER andSize:CGSizeMake(22, 22)];
    [_gitdownbtn setImage:gitdownimage forState:UIControlStateNormal];
    [_gitdownbtn ug_radius:30];
    [_gitdownbtn ug_borderColor:UIColor.whiteColor width:1];
     [_gitdownbtn setUg_Alignment: UGAlignmentBottom];
    _gitdownbtn.titleLabel.font = FONT_SYS12;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_addtargetbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KPAND_MIN);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    
    [_gitupbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addtargetbtn.mas_bottom).mas_offset(KPAND_MIN);
        make.right.mas_equalTo(self.mas_centerX).mas_offset(-KPAND_MIN);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_gitdownbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addtargetbtn.mas_bottom).mas_offset(KPAND_MIN);
        make.left.mas_equalTo(self.mas_centerX).mas_offset(KPAND_MIN);;
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.mas_equalTo(self).mas_offset(-KPAND_MIN);
    }];
}
@end
