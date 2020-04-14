//
//  UIView+UG.m
//  Nextcloud
//
//  Created by admin on 2019/3/12.
//  Copyright © 2019 TWS. All rights reserved.
//

#import "UIView+UG.h"


@implementation UIView (UG)

/**
 * 设置圆角
 */
-(void)ug_radius:(CGFloat)radius{
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
}

/**
 * setCornerRadius   给view设置圆角
 * @param radius      圆角大小
 * @param rectCorner 圆角位置
 **/
- (void)ug_radius:(CGFloat)radius addcorners:(UIRectCorner)rectCorner{
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}

/**
 * 设置边框与边框颜色
 */
-(void)ug_borderColor:(UIColor *)acolor width:(CGFloat)width{
    self.layer.borderWidth = width;
    self.layer.borderColor = acolor.CGColor;
}

-(void)ug_shadowColor:(UIColor *)acolor width:(CGFloat)width{
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity=0.3;///不透明度
    self.layer.shadowColor = acolor.CGColor;//阴影颜色
    self.layer.shadowRadius = width;//半径大小
    self.layer.shadowOffset = CGSizeZero; //设置偏移量为0,四周都有阴影
 
}


@end
