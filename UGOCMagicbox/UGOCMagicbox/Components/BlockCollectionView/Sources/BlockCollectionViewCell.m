//
//  BlockCollectionViewCell.m
//  UbunGit_OC
//
//  Created by MBA on 2019/5/18.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BlockCollectionViewCell.h"
#import "Masonry.h"

@implementation BlockCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageView ug_radius:3];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
}


@end
