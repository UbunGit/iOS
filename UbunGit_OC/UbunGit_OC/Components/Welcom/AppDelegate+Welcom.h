//
//  AppDelegate+Welcom.h
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Welcom)

/**
 * 配置广告图
 */
-(void)configDMViewController:(WelcomBlock)endblock;

/**
 * 配置引导页
 */
-(void)configWelcom:(WelcomBlock)endblock;
@end

NS_ASSUME_NONNULL_END
