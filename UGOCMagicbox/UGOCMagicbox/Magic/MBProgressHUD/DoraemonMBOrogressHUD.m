//
//  DoraemonMBOrogressHUD.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DoraemonMBOrogressHUD.h"

#import "MBProgressHUDTableVC.h"
#import "DoraemonUtil.h"
@implementation DoraemonMBOrogressHUD
- (void)pluginDidLoad{
    MBProgressHUDTableVC *vc = [[MBProgressHUDTableVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}
@end
