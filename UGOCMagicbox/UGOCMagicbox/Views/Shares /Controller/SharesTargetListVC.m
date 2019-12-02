//
//  SharesTargetListVC.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/28.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesTargetListVC.h"

#import "SharesTargetData.h"
#import "SharesTargetSettingVC.h"

@interface SharesTargetListVC ()
@property(strong, nonatomic) RLMResults<SharesTargetData *> *datalist; //历史测评记录
@property(strong, nonatomic) BlockTableView *blockTableView;
@end

@implementation SharesTargetListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updataData];
}
-(void)updataData{
    self.datalist = [SharesTargetData allObjects];
    [_blockTableView reloadData];
}

-(void)configUI{
     UG_WEAKSELF
    self.title = @"指标库";
     UIButton *itemButtom = [UIButton  buttonWithType:UIButtonTypeContactAdd];
       [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        
        [self.navigationController pushViewController:[SharesTargetSettingVC new] animated:YES];
    }];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
    [self.navigationItem setRightBarButtonItems:@[button]];

    self.blockTableView = [BlockTableView new];
    [self.view addSubview:_blockTableView];
    
    
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return weakSelf.datalist.count;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: @"cellid"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SharesTargetData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",data.title];
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 44;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
         SharesTargetData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
    
        SharesTargetSettingVC *sharesTargetSettingVC = [SharesTargetSettingVC new];
        sharesTargetSettingVC.data = data;
        [weakSelf.navigationController pushViewController:sharesTargetSettingVC animated:YES];
    };
    
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
