//
//  UGAlignmentButton.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/18.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGAlignmentButton.h"

@implementation UGAlignmentButton
-(void)setUg_pand:(CGFloat)ug_pand{
    _ug_pand = ug_pand;
    [self setNeedsLayout];
}
-(void)setUg_Alignment:(UGAlignment)ug_Alignment{
    _ug_Alignment = ug_Alignment;
    [self setNeedsLayout];
}

-(void)ug_resetUI{
    switch (_ug_Alignment) {
            //默认
        case UGAlignmentDefual:{
            
            self.titleEdgeInsets = UIEdgeInsetsMake(.0, .0, .0, .0);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0, .0, .0, .0);
        }
            break;
            
            //左字右图
        case UGAlignmentLeft:{
            
            self.titleEdgeInsets = UIEdgeInsetsMake(.0, - self.imageView.bounds.size.width - _ug_pand, .0, self.imageView.bounds.size.width);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0, self.titleLabel.bounds.size.width, .0, - self.titleLabel.bounds.size.width -_ug_pand);
            
        }
            break;
            //左图右字
        case UGAlignmentRight:{
            self.titleEdgeInsets = UIEdgeInsetsMake(.0, _ug_pand, .0, .0);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0, .0, .0, _ug_pand);
            
        }
            break;
            //上字下图
        case UGAlignmentTop:{
            
            self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                    0,
                                                    self.imageView.frame.size.height + _ug_pand,
                                                    self.imageView.bounds.size.width);
            self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.frame.size.height + _ug_pand,
                                                    self.titleLabel.bounds.size.width / 2,
                                                    0,
                                                    -self.titleLabel.bounds.size.width / 2);
        }
            break;
            //上图下字
        case UGAlignmentBottom:{
            self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.frame.size.height + _ug_pand, - self.imageView.bounds.size.width, .0, .0);
            self.imageEdgeInsets = UIEdgeInsetsMake(.0,
                                                    self.titleLabel.bounds.size.width / 2,
                                                    self.titleLabel.frame.size.height + _ug_pand,
                                                    - self.titleLabel.bounds.size.width / 2);
            
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self ug_resetUI];
}
@end
