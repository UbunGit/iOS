//
//  UIApplication+Timer.m
//  VideoHeadline
//
//  Created by admin on 2019/8/21.
//  Copyright © 2019 IgCoding. All rights reserved.
//

#import "UIApplication+Timer.h"


@implementation UIApplication (Timer)

/**
 * 开启一个全局常驻通知定时器，每一秒发送一次通知
 */
-(void)startGloableTimer{
    
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GloableTimer" object:nil];
    } repeats:YES];
   
 
    
}


@end
