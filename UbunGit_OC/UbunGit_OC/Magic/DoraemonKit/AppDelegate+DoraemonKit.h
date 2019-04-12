//
//  AppDelegate+DoraemonKit.h
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate.h"
#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (DoraemonKit)

/**
 * 配置DoraemonKit
 */
-(void)configDoraemonKit;

@end

NS_ASSUME_NONNULL_END
