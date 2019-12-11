//
//  UIApplication+Timer.h
//  VideoHeadline
//
//  Created by admin on 2019/8/21.
//  Copyright © 2019 IgCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Timer)

/**
 * 开启一个全局常驻通知定时器，每一秒发送一次通知
 */
-(void)startGloableTimer;

@end

NS_ASSUME_NONNULL_END
