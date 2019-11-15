//
//  UIControl+UG.h
//  LHCloud
//
//  Created by admin on 2019/5/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^ug_ButtonActionBlock)(id sender);

@interface UIControl (UG)

@property (nonatomic, assign) NSTimeInterval ug_eventInterval;//button 点击间隔时间

/**
 * 添加 block 事件
 */
-(void)ug_addEvents:(UIControlEvents)event andBlock:(ug_ButtonActionBlock)block;

/**
 * 添加 block 事件
 * eventInterval 点击间隔时间内不能响应
 */
-(void)ug_addEvents:(UIControlEvents)event eventInterval:(NSTimeInterval)eventInterval andBlock:(ug_ButtonActionBlock)block;

@end

NS_ASSUME_NONNULL_END
