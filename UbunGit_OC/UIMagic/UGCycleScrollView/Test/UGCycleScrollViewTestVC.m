//
//  UGCycleScrollViewTestVC.m
//  UbunGit_OC
//
//  Created by MBA on 2019/5/18.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UGCycleScrollViewTestVC.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "UIView+Alert.h"
#import "UGCycleScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UGCycleScrollViewTestVC ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic)UITableView *tableview;

@property(strong, nonatomic)NSArray *tableDatas;

@end

@implementation UGCycleScrollViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}
-(void)initUI{
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [UITableView new];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    
}

-(void)loadData{
    self.tableDatas = @[@"小轮播",@"有边距轮播"];
    [_tableview reloadData];
}
#pragma mark - TableViewDatasouce/TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDatas.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"1"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSString *title = [_tableDatas objectAtIndex:indexPath.row];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[@"http://static1.pezy.cn/img/2019-02-01/5932241902444072231.jpg", @"http://static1.pezy.cn/img/2019-03-01/1206059142424414231.jpg",@"http://static1.pezy.cn/img/2019-02-01/5932241902444072231.jpg", @"http://static1.pezy.cn/img/2019-03-01/1206059142424414231.jpg"];
    
    NSString *title = [_tableDatas objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"小轮播"]) {
        
        UGCycleScrollView *temview = [UGCycleScrollView new];
        [temview setItemSize:CGSizeMake(350, 200)];
        [temview setItemSpacing:0];
        [temview setUg_numberOfItemsInSection:^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
            return array.count*1000;
        }];
        [temview setUg_cellForItemAtIndexPath:^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
            UGCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            NSString *urlstr = [array objectAtIndex:indexPath.row%array.count];
            NSURL *url = [NSURL URLWithString:urlstr];
            [cell.imageView sd_setImageWithURL:url];
            return cell;
        }];
        temview.backgroundColor = [UIColor yellowColor];
        [self.view ug_alertview:temview];
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(350);
            make.height.mas_equalTo(200);
        }];

    }else if([title isEqualToString:@"有边距轮播"]){
        
        
        UGCycleScrollView *temview = [UGCycleScrollView new];
        [temview setItemSize:CGSizeMake(300, 200)];
        [temview setItemSpacing:12];
        [temview setUg_numberOfItemsInSection:^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
            return MAXFLOAT;
        }];
        [temview setUg_cellForItemAtIndexPath:^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
            
            UGCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            NSString *urlstr = [array objectAtIndex:indexPath.row%array.count];
            NSURL *url = [NSURL URLWithString:urlstr];
            [cell.imageView sd_setImageWithURL:url];
            cell.imageView.cornerRadius = 8;
            return cell;
        }];
     
        [self.view ug_alertview:temview];
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(350);
            make.height.mas_equalTo(220);
        }];
        
        temview.backgroundColor = [UIColor whiteColor];
    }
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
}
@end
