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

-(void)confitUI{
    self.titleLab = [UILabel new];
    _titleLab.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    _titleLab.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-github"];
    [self addSubview:_titleLab];
}
-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
@end
