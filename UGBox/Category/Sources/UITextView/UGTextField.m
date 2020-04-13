//
//  UGTextField.m
//  LifeBox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "UGTextField.h"

@implementation UGTextField
-(instancetype)init{
    if (self == [super init]) {
        self.offset = 10;
    }
    return self;
}
-(void)setOffset:(CGFloat)offset{
    _offset = offset;
    [self setNeedsLayout];
}
// 未输入时文本的位置，向右缩进10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _offset, 0);
}
// 输入后文本的位置，向右缩进10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _offset, 0);
}

@end
