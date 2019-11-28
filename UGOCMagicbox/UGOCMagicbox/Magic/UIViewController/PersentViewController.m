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
    if (_cotentView) {
        [self.view addSubview:_cotentView];
        [_cotentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.centerY).mas_offset(-80);
            make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
            make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        }];
    }
    [_cotentView addGestureRecognizer:[UIGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        CALayer *testViewLayer = self.cotentView.layer.presentationLayer;
       
        if (!CGRectContainsPoint(testViewLayer.frame, location)) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }]];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}


@end
