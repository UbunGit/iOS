//
//  UGKeyValueView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGKeyValueView.h"

@implementation UGKeyValueView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.keylab = [UILabel new];
    [self addSubview:_keylab];
    
    self.valuelab = [UILabel new];
    [self addSubview:_valuelab];
}

-(void)setKey:(NSString *)key{
    _key = key;
    self.keylab.text = key;
    [self setNeedsLayout];
}

-(void)setVlaue:(NSString *)vlaue{
    _vlaue = vlaue;
    self.valuelab.text = vlaue;
    [self setNeedsLayout];
}

-(void)setPanding:(CGFloat)panding{
    _panding = panding;
    [self setNeedsLayout];
}
-(void)setEdge:(UIEdgeInsets)edge{
    _edge = edge;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_keylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(_edge.left);
        make.top.mas_equalTo(self).mas_offset(_edge.top);
    }];
    
    [_valuelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.keylab.mas_right).mas_offset(self.panding);
        make.top.mas_equalTo(self).mas_offset(_edge.top);
        make.right.mas_equalTo(self).mas_offset(-_edge.right);
        make.bottom.mas_equalTo(self).mas_offset(-_edge.bottom);
    }];
}
@end
