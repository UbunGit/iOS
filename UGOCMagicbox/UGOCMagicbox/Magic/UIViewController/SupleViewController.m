//
//  SupleViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SupleViewController.h"

@interface SupleViewController ()

@end

@implementation SupleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.definesPresentationContext = YES;//self 为presenting 视图
    //导航拦
    if (self.navigationController.viewControllers.count > 1) {
            UIButton *itemButtom = [UIButton new];
        [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
        NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FAAngleLeft];
        [itemButtom.titleLabel setFont:FONT_FA20];
        [itemButtom setTitleColor:COLOR23 forState:UIControlStateNormal];
        [itemButtom setTitle:bcaktitle forState:UIControlStateNormal];
        [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
           
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                   initWithCustomView:itemButtom];
        [self.navigationItem setLeftBarButtonItems:@[button]];
    }

}



@end
