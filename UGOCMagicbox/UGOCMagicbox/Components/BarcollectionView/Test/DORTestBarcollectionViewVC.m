//
//  DORTestBarcollectionViewVC.m
//  UbunGit_OC
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DORTestBarcollectionViewVC.h"
#import "BarcollectionView.h"

@interface DORTestBarcollectionViewVC ()

@property(strong, nonatomic)BarcollectionView *barcollectionView;

@end

@implementation DORTestBarcollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.barcollectionView = [BarcollectionView new];
    [self.view addSubview:_barcollectionView];
    _barcollectionView.backgroundColor = [UIColor ug_random];
//    barcollectionView.mas_ma
}
-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_barcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(200);
        make.height.equalTo(@44);
    }];
}
@end
