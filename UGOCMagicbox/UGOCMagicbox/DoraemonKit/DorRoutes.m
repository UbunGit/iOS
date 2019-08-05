//
//  DorRoutes.m
//  UbunGit_OC
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DorRoutes.h"
#import "DoraemonUtil.h"
#import "BlockCollectionViewTestVC.h"

@implementation DorRoutes

@end

//轮播图
@implementation DoraemonBlockCollectionView

- (void)pluginDidLoad{
    BlockCollectionViewTestVC *vc = [[BlockCollectionViewTestVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end

#import "DORTestBarcollectionViewVC.h"
// 常用collertiom
@implementation DorBarcollectionView

- (void)pluginDidLoad{
    DORTestBarcollectionViewVC *vc = [[DORTestBarcollectionViewVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end



#import "BlockTableviewTestVC.h"
// 常用Tableview
@implementation DorBlockTableviewTestVC

- (void)pluginDidLoad{
    BlockTableviewTestVC *vc = [[BlockTableviewTestVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}


@end 

#import "MBProgressHUDTableVC.h"
// 常用Tableview
@implementation DoraemonMBOrogressHUD

- (void)pluginDidLoad{
    MBProgressHUDTableVC *vc = [[MBProgressHUDTableVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}
@end

#import "UGDrawingVC.h"
// 常用Tableview
@implementation DorUGDrawingView

- (void)pluginDidLoad{
    UGDrawingVC *vc = [[UGDrawingVC alloc] init];
    [DoraemonUtil openPlugin:vc];
}
@end

