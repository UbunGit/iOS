//
//  AppDelegate+NIMSDK.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate+NIMSDK.h"
#import <NIMSDK/NIMSDK.h>
@implementation AppDelegate (NIMSDK)

-(void)configNIMSDK{
    //推荐在程序启动的时候初始化 NIMSDK
    NSString *appKey        = @"2c59004d07d224c656487430966b3c84";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"your APNs cer name";
    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
}
@end
