//
//  AppDelegate+CocoaLumberjack.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate+CocoaLumberjack.h"



@implementation AppDelegate (CocoaLumberjack)

-(void)configCocoaLumberjack{
    
    [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:ddLogLevel]; // Uses os_log
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger withLevel:ddLogLevel];
    
}
@end
