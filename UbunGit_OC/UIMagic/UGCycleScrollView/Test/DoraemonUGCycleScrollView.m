//
//  DoraemonUGCycleScrollView.m
//  UbunGit_OC
//
//  Created by MBA on 2019/5/18.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DoraemonUGCycleScrollView.h"
#import "UGCycleScrollViewTestVC.h"
#import "DoraemonUtil.h"
@implementation DoraemonUGCycleScrollView


- (void)pluginDidLoad{
    UGCycleScrollViewTestVC *vc = [[UGCycleScrollViewTestVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}
@end
