//
//  AppDelegate+TavBar.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate+TavBar.h"
#import "RTRootNavigationController.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "AboutMeVC.h"
#import "MapViewController.h"
#import "FATableViewController.h"
#import "SharesListVC.h"
#import "DanmuViewController.h"



@implementation AppDelegate (TavBar)

-(void)configTabBar{
    
    HomeViewController *vc1 = [HomeViewController new];
    vc1.title = @"VC1";
    RTRootNavigationController *nav1 = [[RTRootNavigationController alloc] initWithRootViewController:vc1];
    
    
    // 视图控制器的分栏按钮
    // 视图控制器的分栏按钮，如果没有被显示创建，并且被使用了，则会自动根据视图控制器的title来创建
    //vc1.tabBarItem;
    
    AboutMeVC *vc2 = [[AboutMeVC alloc] init];
    vc2.title = @"VC2";
    RTRootNavigationController *nav2 = [[RTRootNavigationController alloc] initWithRootViewController:vc2];
    
    MapViewController *vc3 = [[MapViewController alloc] init];
    vc3.title = @"地图";
    RTRootNavigationController *nav3 = [[RTRootNavigationController alloc] initWithRootViewController:vc3];
    
    SharesListVC *vc4 = [[SharesListVC alloc] init];
    vc4.title = @"股票";
 
    RTRootNavigationController *nav4 = [[RTRootNavigationController alloc] initWithRootViewController:vc4];
 
    
    FATableViewController *vc5 = [[FATableViewController alloc] init];
    vc5.title = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-user"];
    RTRootNavigationController *nav5 = [[RTRootNavigationController alloc] initWithRootViewController:vc5];
    
    DanmuViewController *vc6 = [[DanmuViewController alloc] init];
    vc6.title = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-user"];
    RTRootNavigationController *nav6 = [[RTRootNavigationController alloc] initWithRootViewController:vc6];
    
    // 创建分栏(标签栏)控制器, 和导航控制器一样，都是用来管理视图控制器的容器类型的控制器。
    // 分栏控制器和导航控制器一样，也是通过viewControllers来管理其子视图控制器
    UITabBarController *tabBarCtrl = [[UITabBarController alloc] init];
  
    tabBarCtrl.view.backgroundColor = [UIColor cyanColor];
    
    // 把数据中得视图器交给分栏控制器管理
    // 分栏控制器会自动将其管理的视图控制器的分栏按钮(UITabBarItem)放到分栏上显示
    tabBarCtrl.viewControllers = @[nav4, nav2, nav3, nav1,nav5,nav6];
    
    // 设置窗口的跟视图控制器为分栏控制器
    self.window.rootViewController = tabBarCtrl;
    
    // 取到分栏控制器的分栏
    UITabBar *tabBar = tabBarCtrl.tabBar;
    
    // 设置分栏的风格
    tabBar.barStyle = UIBarStyleBlack;
    
    // 是否透明
    tabBar.translucent = NO;
    
    // 设置分栏的前景颜色
    tabBar.barTintColor = [UIColor clearColor];
    
    // 设置分栏元素项的颜色
    tabBar.tintColor = [UIColor whiteColor];
    
    // 设置分栏按钮的选中指定图片
    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"home.png"];
    
    [self.window makeKeyAndVisible];
}
@end
