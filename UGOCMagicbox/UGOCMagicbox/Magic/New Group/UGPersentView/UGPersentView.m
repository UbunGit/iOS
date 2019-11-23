//
//  UGPersentView.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGPersentView.h"

@implementation UGPersentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self conficUI];
    }
    return self;
}

-(void)conficUI{
    
    self.backgroundColor = COLOR00_04;
}

-(void)didAddSubview:(UIView *)subview{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(subview);
    }];
}
@end
