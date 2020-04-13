//
//  UGImageView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGImageView.h"

@implementation UGImageView

-(void)setIsround:(BOOL)isround{
    _isround = isround;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_isround) {
        self.layer.cornerRadius = CGRectGetWidth(self.bounds)/2;
        self.layer.masksToBounds = YES;
    }
}
@end
