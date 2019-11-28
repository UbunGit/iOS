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
    //导航拦
    if (self.navigationController.viewControllers.count > 0) {
            UIButton *itemButtom = [UIButton new];
        [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
        NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FAAngleLeft];
        [itemButtom.titleLabel setFont:FONT_FA20];
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
