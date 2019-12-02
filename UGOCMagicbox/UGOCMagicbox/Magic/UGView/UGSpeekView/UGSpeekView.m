//
//  UGSpeekView.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGSpeekView.h"

@implementation UGSpeekView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    self.contentView = [UIView new];
    [self addSubview:_contentView];
    
    self.waverView = [UGWaverView new];
    [self.contentView addSubview:_waverView];
  
    
    self.cenImageView = [UIImageView new];
    [self addSubview:_cenImageView];
    
    self.closeBtn = [UIButton new];
    [self addSubview:_closeBtn];

    
    [_cenImageView setImage:UGIMAGE(@"jqr_zy")];
    [_contentView setBackgroundColor:UIColor.ug_random];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_cenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KAutoAcale(73), KAutoAcale(73)));
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cenImageView.mas_centerY);
        make.left.right.bottom.mas_equalTo(self);
    }];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(KAutoAcale(44), KAutoAcale(44)));
    }];
    [_waverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
}
@end
