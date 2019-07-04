//
//  LocView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/3.
//  Copyright © 2019 UG. All rights reserved.
//

#import "LocView.h"

@implementation LocView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self confitUI];
    }
    return self;
}
-(id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
         [self confitUI];
    }
    return  self;
}

-(void)confitUI{
    [self setFrame:CGRectMake(0, 0, 55, 55)];
    {
        //用户名
        self.titleLab = [UILabel new];
        _titleLab.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
        _titleLab.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-github"];
        [self addSubview:_titleLab];
    }
    {
        //头像
        self.headImageview = [UIImageView new];
        [self addSubview:_headImageview];
        
    }
    {
        //点击btn
        self.clickbtn = [UIButton new];
        [self addSubview:_clickbtn];
        
    }
}
-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(@2);
        make.left.mas_equalTo(self).mas_offset(@2);
        make.right.mas_equalTo(self).mas_offset(@2);
        make.height.mas_equalTo(self).mas_offset(@20);
    }];
    [_headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(@2);
        make.left.mas_equalTo(self).mas_offset(@2);
        make.right.mas_equalTo(self).mas_offset(@2);
        make.bottom.mas_equalTo(self).mas_offset(@22);
        
    }];
    [_clickbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
@end
