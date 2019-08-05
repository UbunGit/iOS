//
//  DMViewController.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DMViewController.h"
#import "Masonry.h"

@interface DMViewController ()

@end

@implementation DMViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.cancelbtn = [UIButton new];
    [self.view addSubview:_cancelbtn];
    UIColor *titleColoe = [UIColor colorWithRed:((float)((0x666666 & 0xFF0000) >> 16))/255.0
                                          green:((float)((0x666666 & 0xFF00) >> 8))/255.0
                                           blue:((float)(0x666666 & 0xFF))/255.0 alpha:1.0];
    [_cancelbtn setTitleColor:titleColoe forState:UIControlStateNormal];
    _cancelbtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_cancelbtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_cancelbtn addTarget:self action:@selector(gotoNext:) forControlEvents:UIControlEventTouchUpInside];
    [self performSelector:@selector(gotoNext:) withObject:nil afterDelay:3];
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(8+[[UIApplication sharedApplication] statusBarFrame].size.height);
    }];
    
}
-(void)gotoNext:(UIButton*)sender{
    if (_endBlock) {
        _endBlock(sender);
    }
}
@end
