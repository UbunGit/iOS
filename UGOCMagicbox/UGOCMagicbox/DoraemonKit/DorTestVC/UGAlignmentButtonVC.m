//
//  UGAlignmentButtonVC.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/18.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGAlignmentButtonVC.h"
#import "UGAlignmentButton.h"
@interface UGAlignmentButtonVC ()

@property(strong, nonatomic) UGAlignmentButton * testBtn;

@end

@implementation UGAlignmentButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.testBtn = [UGAlignmentButton new];
    [self.view addSubview:_testBtn];
    [_testBtn setBackgroundColor:UIColor.yellowColor];
    [_testBtn setTitle:@"hahah" forState:UIControlStateNormal];
    [_testBtn setImage:UGIMAGE(@"家-icon-白色") forState:UIControlStateNormal];
    [_testBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        _testBtn.ug_pand = 20;
        if (_testBtn.ug_Alignment == UGAlignmentBottom) {
            _testBtn.ug_Alignment = 0;
        }else{
            _testBtn.ug_Alignment ++;
        }
    }];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}

@end
