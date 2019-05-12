//
//  DoraemonTZImagePick.m
//  UbunGit_OC
//
//  Created by admin on 2019/5/12.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DoraemonTZImagePick.h"
#import "UG_TZImagePickSwitch.h"
#import "DoraemonUtil.h"

@implementation DoraemonTZImagePick

- (void)pluginDidLoad{
    UG_TZImagePickSwitch *vc = [[UG_TZImagePickSwitch alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end
