//
//  UGRemarkView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UGRemarkView : UIView

@property(strong,nonatomic) NSString *text;

@property (nonatomic, strong) UILabel *titlaLabel; //中间圆形图片

@property(strong, nonatomic) UITextView *textView;//输入框

@end

NS_ASSUME_NONNULL_END
