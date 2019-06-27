//
//  AppDelegate+Welcom.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AppDelegate+Welcom.h"
#import "DMViewController.h"
@implementation AppDelegate (Welcom)

/**
 * 配置广告图
 */
-(void)configDMViewController:(WelcomBlock)endblock{
    
    DMViewController* welcomvc = [DMViewController new];
    self.window.rootViewController = welcomvc;
    [self.window makeKeyAndVisible];
    welcomvc.endBlock = endblock;
}

/**
 * 配置引导页
 */
-(void)configWelcom:(WelcomBlock)endblock{
    
    
    NSString *olevercode = [[NSUserDefaults standardUserDefaults]objectForKey:@"APPVersionString"];
    olevercode = [NSString stringWithFormat:@"%zd",random()%1000];
    NSString *vercode = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([vercode isEqualToString:olevercode]) {
        endblock(nil);
    }else{
        WelcomViewController* welcomvc = [WelcomViewController new];
        
        self.window.rootViewController = welcomvc;
        [self.window makeKeyAndVisible];
        [welcomvc setImageArr:@[@"iosyingdaoye1",@"iosyingdaoye2",@"iosyingdaoye3"]];
        [welcomvc.welcombtn setTitle:@"立即开启" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:vercode forKey:@"APPVersionString"];
        welcomvc.endBlock = endblock;
    }
    
}
@end
