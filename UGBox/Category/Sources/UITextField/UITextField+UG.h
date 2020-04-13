//
//  UITextField+UG.h
//  LHCloud
//
//  Created by admin on 2019/3/25.
//  Copyright © 2019 admin. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextField (UG)

/**
 *  文本最大支持多少个字符，设置后会自动根据该属性截取文本字符长度
 */
@property (nonatomic, assign) NSInteger ug_maximumLimit;

/**
 *  文本发生改变时回调
 */
- (void)ug_textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码
 */
- (void)ug_fixMessyDisplay;

@end

NS_ASSUME_NONNULL_END
