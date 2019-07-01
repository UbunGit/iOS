//
//  HomeViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/1.
//  Copyright © 2019 UG. All rights reserved.
//

#import "HomeViewController.h"
#import "BlockTableView.h"
#import <TABKit/TABKit.h>
@interface HomeViewController ()

@property(strong, nonatomic) BlockTableView *blockTableView;
@property(strong, nonatomic) NSMutableArray *datalist;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configdata];
    [self configUI];

}
-(void)viewWillAppear:(BOOL)animated{
    [self tabAnimated];
}
-(void)configdata{
    self.datalist = [NSMutableArray arrayWithCapacity:0];
}
-(void)configUI{
    self.blockTableView = [BlockTableView new];
    [self.view addSubview:_blockTableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 120)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((375 - 80)/2.0, 20, 80, 80)];
    imageV.image = [UIImage imageNamed:@"comic.jpg"];
    imageV.layer.cornerRadius = 80/2.0;
    imageV.layer.masksToBounds = YES;
    [view addSubview:imageV];
    _blockTableView.tableview.tableHeaderView = view;
    
    [_blockTableView.tableview registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCell"];
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return self.datalist.count;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
//        TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = UIColor.ug_random;
//        cell.titleLab.text = [NSString stringWithFormat:@"鬼灭之刃第1集"];
//        cell.timeLab.text = @"发布时间：2018-09-12";
//        [cell.gameImg setImage:[UIImage imageNamed:@"comic.jpg"]];
//
//        [cell.statusBtn setTitle:@"未观看" forState:UIControlStateNormal];
//        [cell.statusBtn setBackgroundColor:[UIColor grayColor]];
//        return cell;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = @"ceshi";
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 44;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        [self.view alert:@"00"];
    };

}
-(void)tabAnimated{
     _blockTableView.tableview.tabAnimated = [TABTableAnimated animatedWithCellClass:[TestTableViewCell class] cellHeight:100];
    _blockTableView.tableview.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
        view.animation(1).down(3).height(12);
        view.animation(2).height(12).width(110);
        view.animation(3).down(-5).height(12);
    };
   
    [_blockTableView.tableview tab_startAnimationWithDelayTime:5. completion:^{
        [self afterGetData];
        [self.blockTableView.tableview tab_endAnimationEaseOut];
    }];
    
   
  
}

-(void)afterGetData{
    [_datalist removeAllObjects];
    for (int i = 0; i < 10; i ++) {
        [_datalist addObject:@{
                               @"title":@"测试",
                               @"icons":@[@"ee",@"ee"],
                               @"def":@""
                               }];
    }
    [_blockTableView.tableview reloadData];
}
-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
