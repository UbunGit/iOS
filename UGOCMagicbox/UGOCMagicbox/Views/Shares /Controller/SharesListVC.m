//
//  SharesListVC.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesListVC.h"

#import "PersentViewController.h"
#import "SharesAddView.h"
@interface SharesListVC ()

@end

@implementation SharesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //导航拦
    UIButton *itemButtom = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    
    [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        SharesAddView *sharesAddView = [SharesAddView new];
        PersentViewController *persent = [PersentViewController new];
        persent.cotentView = sharesAddView;
        [self presentViewController:persent animated:YES completion:nil];
    }];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
    [self.navigationItem setRightBarButtonItems:@[button]];
}
@end
