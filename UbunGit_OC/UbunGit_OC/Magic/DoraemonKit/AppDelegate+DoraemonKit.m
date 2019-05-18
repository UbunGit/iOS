//
//  AppDelegate+DoraemonKit.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate+DoraemonKit.h"


@implementation AppDelegate (DoraemonKit)

/**
 * 配置DoraemonKit
 */
-(void)configDoraemonKit{
#ifdef DEBUG
//UI
    [[DoraemonManager shareInstance] addPluginWithTitle:@"通讯录" icon:@"doraemon_netflow_list_select" desc:@"用于app内部环境切换功能" pluginName:@"DoraemonAddressBook" atModule:@"功能测试"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"腾讯视频" icon:@"doraemon_netflow_list_select" desc:@"用于腾讯SuperPlayer集成测试" pluginName:@"DoraemonSuperPlay" atModule:@"功能测试"];
//常用功能

    [[DoraemonManager shareInstance] install];
#endif
}
@end
