//
//  ShareOptionCell.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/12/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import "ShareOptionCell.h"

@implementation ShareOptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    
    self.selectImage = [FAImageView new];
    [self.contentView addSubview:_selectImage];
    [_selectImage ug_radius:6];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-KPAND_DEF);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
}
@end
