//
//  UITextView+UG.h
//
//  Created by  admin on 2018/11/27.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (UG)

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *ug_placeholderStr;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *ug_placeholderColor;

/**
 *  最大显示字符限制(会自动根据该属性截取文本字符长度)
 */
@property (nonatomic, assign) NSInteger ug_maximumLimit;

/**
 *  右下角字符长度提示(需要设置maximumLimit属性)，与占位文本颜色、字号一致  默认NO
 */
@property (nonatomic, assign) BOOL ug_characterLengthPrompt;

/**
 *  文本发生改变时回调
 */
- (void)ug_textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)ug_fixMessyDisplay;

@end

NS_ASSUME_NONNULL_END
