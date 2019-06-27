//
//  UIColor+UG.h
//  UbunGit_OC
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (UG)
+ (UIColor*)ug_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

+ (UIColor *)ug_hexString:(NSString *)color;

+ (UIColor*)ug_random;
@end

NS_ASSUME_NONNULL_END
