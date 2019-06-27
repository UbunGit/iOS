//
//  BlockTableviewTestVC.m
//  UbunGit_OC
//
//  Created by admin on 2019/6/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BlockTableviewTestVC.h"
#import "BlockTableView.h"
@interface BlockTableviewTestVC ()
@property(strong, nonatomic) BlockTableView* blockTableView;
@end

@implementation BlockTableviewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    
    self.blockTableView = [BlockTableView new];
    [self.view addSubview:_blockTableView];
    _blockTableView.backgroundColor = UIColor.ug_random;
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return 13;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        DDLogVerbose(@"点击了%@",indexPath);
    };
    
}

@end
