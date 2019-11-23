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
-(void)ug_Radius:(CGFloat)radius{
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
@end
