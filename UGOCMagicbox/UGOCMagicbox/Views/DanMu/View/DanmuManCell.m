//
//  DanmuManCell.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DanmuManCell.h"
#define ImageWidth 40.0
#define ImageHeight 40.0
@implementation DanmuManCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    //因为在点击的时候被改为了红色, 所以在重用的时候, 要重置一下颜色
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)addSubviews {
    [self addSubview:self.middleImageView];
    [self addSubview:self.leftImageView];
}

- (void)updateSubviewsData {
    [super updateSubviewsData];
    
    [self.leftImageView sd_setImageWithURL:UGURL(@"https://github.com/UbunGit/TestRepo/raw/master/image/animal/0.jpg") placeholderImage:UGIMAGE(@"img_1")];
    [self.middleImageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];

}

- (void)layoutContentSubviews {
    [super layoutContentSubviews];
    
    CGFloat leftImageViewX = 0.0;
    CGFloat leftImageViewY = 0.0;
    CGFloat leftImageViewW = ImageWidth;
    CGFloat leftImageViewH = ImageHeight;
    self.leftImageView.frame = CGRectMake(leftImageViewX, leftImageViewY, leftImageViewW, leftImageViewH);
    
    CGFloat middleImageViewW = CGRectGetWidth(self.textLabel.bounds);
    CGFloat middleImageViewH = KAutoAcale(22);
    CGFloat middleImageViewX = CGRectGetMaxX(self.leftImageView.bounds) ;
    CGFloat middleImageViewY = (leftImageViewH - middleImageViewH)/2;
    self.middleImageView.frame = CGRectMake(middleImageViewX- 10.0, middleImageViewY, middleImageViewW+20, middleImageViewH);
    
    
    self.textLabel.frame = CGRectMake(middleImageViewX, middleImageViewY, middleImageViewW, middleImageViewH);
    
   
}

- (void)convertContentToImage {
//    UIImage *contentImage = [self.layer convertContentToImageWithSize:CGSizeMake(CGRectGetMaxX(self.rightImageView.frame), CGRectGetMaxY(self.rightImageView.frame))];
//    [self.layer setContents:(__bridge id)contentImage.CGImage];
}

- (void)removeSubViewsAndSublayers {
    //如果不要删除leftImageView, middleImageView, rightImageView, textLabel, 只需重写这个方法并留空就可以了.
    //比如: 你想在这个cell被点击的时候, 修改文本颜色
}

#pragma mark ---- setter
- (void)setBarrageDescriptor:(OCBarrageDescriptor *)barrageDescriptor {
    [super setBarrageDescriptor:barrageDescriptor];
    self.danmuManDescriptor = (DanmuManDescriptor *)barrageDescriptor;
}

#pragma mark ---- getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_leftImageView ug_radius:ImageWidth/2];
        [_leftImageView ug_borderColor:[UIColor ug_hexString:@"#FF5825"] width:1];
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_middleImageView ug_radius:11];
        [_middleImageView ug_borderColor:[UIColor ug_hexString:@"#FF5825"] width:1];
    }
    return _middleImageView;
}


@end
