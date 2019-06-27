//
//  AppDelegate+CocoaLumberjack.h
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CocoaLumberjack)

/**
 * 配置日志
 */
-(void)configCocoaLumberjack;
@end

NS_ASSUME_NONNULL_END
