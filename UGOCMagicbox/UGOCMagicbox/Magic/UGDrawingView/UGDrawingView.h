//
//  UGDrawingView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/7/8.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UGDrawingView : UIView

// 用来设置线条的颜色
@property (nonatomic, strong) UIColor *color;
// 用来设置线条的宽度
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) BOOL isEnable;//是否允许画图 defual YES

@property (copy, nonatomic) void(^onecepand)(NSArray * points);

@end

NS_ASSUME_NONNULL_END
