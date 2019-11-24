//
//  UGRemarkView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGRemarkView.h"

@implementation UGRemarkView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)setText:(NSString *)text{
    _textView.text = text;
}

-(NSString *)text{
    return _textView.text;
}

-(void)configUI{
    [self ug_radius:5];
  
    self.textView = [UITextView new];
    [self addSubview:_textView];
    [_textView ug_borderColor:COLOREE width:1];
    [_textView ug_radius:5];
    
    self.titlaLabel = [UILabel new];
    [self addSubview:_titlaLabel];
    _titlaLabel.textColor = COLOR23;
    _titlaLabel.font = FONT_SYS12;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_titlaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KPAND_MIN);
        make.left.mas_equalTo(self).mas_offset(KPAND_MIN);
        make.right.mas_equalTo(self);
        
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-KPAND_MIN);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titlaLabel.mas_bottom).mas_offset(KPAND_MIN);
    }];
}

@end
