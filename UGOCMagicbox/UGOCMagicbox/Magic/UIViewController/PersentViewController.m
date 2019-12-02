//
//  PersentViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "PersentViewController.h"

@interface PersentViewController ()

@end

@implementation PersentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = COLOR00_04;
    self.closeBtn = [UIButton new];
   
    NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FADotCircleO];
    [_closeBtn.titleLabel setFont:FONT_FA20];
    [_closeBtn.titleLabel setTextColor:COLOR23];
    [_closeBtn setTitle:bcaktitle forState:UIControlStateNormal];
    [_closeBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    if (_cotentView) {
        [self.view addSubview:_cotentView];
         [self.view addSubview:_closeBtn];
        [_cotentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.centerY).mas_offset(-80);
            make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
            make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        }];
        [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.cotentView.mas_top).mas_offset(-KPAND_DEF);
            make.right.mas_equalTo(self.cotentView).mas_offset(-KPAND_DEF);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];


}


@end
