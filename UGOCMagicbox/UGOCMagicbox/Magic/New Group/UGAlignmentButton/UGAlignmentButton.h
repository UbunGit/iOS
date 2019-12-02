//
//  UGAlignmentButton.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/18.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UGAlignment) {
    UGAlignmentDefual    = 0,    // 系统默认
    UGAlignmentLeft      = 1,    // lable on image left
    UGAlignmentRight     = 2,    // lable on image right
    UGAlignmentTop       = 3,     // lable on image top
    UGAlignmentBottom    = 4,  // lable on image bottom
};

@interface UGAlignmentButton : UIButton

@property(assign, nonatomic) UGAlignment ug_Alignment;
@property(assign, nonatomic) CGFloat ug_pand;//图片跟文字之间的间距 UGAlignmentDefual 下无效
@end

NS_ASSUME_NONNULL_END
