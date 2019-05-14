//
//  DoraemonSuperPlay.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DoraemonSuperPlay.h"
#import "SuperPlayerVC.h"
#import "DoraemonUtil.h"

@interface DoraemonSuperPlay ()

@end

@implementation DoraemonSuperPlay

- (void)pluginDidLoad{
    SuperPlayerVC *vc = [[SuperPlayerVC alloc] init];
    vc.videoURL = @"http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4";
    [DoraemonUtil openPlugin:vc];
}


@end
