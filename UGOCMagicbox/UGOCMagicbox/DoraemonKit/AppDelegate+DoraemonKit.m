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
//    [[DoraemonManager shareInstance] addPluginWithTitle:@"TabBar" icon:@"doraemon_ui" desc:@"类似网易切换" pluginName:@"DoraemonAddressBook" atModule:@"UI"];
//    [[DoraemonManager shareInstance] addPluginWithTitle:@"导航" icon:@"doraemon_ui" desc:@"类似网易切换" pluginName:@"DoraemonAddressBook" atModule:@"UI"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"轮播图" icon:@"doraemon_ui" desc:@"类似网易切换" pluginName:@"DoraemonBlockCollectionView" atModule:@"UI"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"BlockTabview" icon:@"doraemon_ui" desc:@"BlockTabview" pluginName:@"DorBlockTableviewTestVC" atModule:@"UI"];
    
    
 
   
//常用功能
    [[DoraemonManager shareInstance] addPluginWithTitle:@"启动页" icon:@"doraemon_ui" desc:@"启动页" pluginName:@"DorWelcomViewController" atModule:@"常用功能"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"广告页" icon:@"doraemon_ui" desc:@"广告页" pluginName:@"DorDMViewController" atModule:@"常用功能"];
    
    [[DoraemonManager shareInstance] addPluginWithTitle:@"选择栏" icon:@"doraemon_ui" desc:@"类似网易切换" pluginName:@"DorBarcollectionView" atModule:@"常用功能"];
    
    [[DoraemonManager shareInstance] addPluginWithTitle:@"通讯录" icon:@"doraemon_netflow_list_select" desc:@"用于app内部环境切换功能" pluginName:@"DoraemonAddressBook" atModule:@"常用功能"];
    
    [[DoraemonManager shareInstance] addPluginWithTitle:@"腾讯视频" icon:@"doraemon_netflow_list_select" desc:@"用于腾讯SuperPlayer集成测试" pluginName:@"DoraemonSuperPlay" atModule:@"常用功能"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"弹框" icon:@"doraemon_netflow_list_select" desc:@"用于弹框测试" pluginName:@"DoraemonMBOrogressHUD" atModule:@"常用功能"];
    
    [[DoraemonManager shareInstance] addPluginWithTitle:@"相册选择" icon:@"doraemon_netflow_list_select" desc:@"用于TZimagePickviewcontroll" pluginName:@"DoraemonTZImagePick" atModule:@"常用功能"];
    
    [[DoraemonManager shareInstance] addPluginWithTitle:@"画图" icon:@"doraemon_netflow_list_select" desc:@"绘图" pluginName:@"DorUGDrawingView" atModule:@"常用功能"];
    
     [[DoraemonManager shareInstance] addPluginWithTitle:@"SVGA动画" icon:@"doraemon_netflow_list_select" desc:@"SVGA动画" pluginName:@"DorSVGAPlayer" atModule:@"常用功能"];
    [[DoraemonManager shareInstance] addPluginWithTitle:@"lottie动画" icon:@"doraemon_netflow_list_select" desc:@"SVGA动画" pluginName:@"DorLOTViewController" atModule:@"常用功能"];
   
    
    
    

    [[DoraemonManager shareInstance] install];
#endif
}
@end
