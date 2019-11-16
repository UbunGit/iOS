//
//  BlockCollectionViewTestVC.m
//  UbunGit_OC
//
//  Created by MBA on 2019/5/18.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BlockCollectionViewTestVC.h"
#import "Masonry.h"
#import "UIView+Alert.h"
#import "BlockCollectionView.h"
#import "TabbarCollectionCell.h"
#import "TabbarCollectionCenCell.h"


@interface BlockCollectionViewTestVC ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic)UITableView *tableview;

@property(strong, nonatomic)NSArray *tableDatas;

@end

@implementation BlockCollectionViewTestVC

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
    self.tableDatas = @[@"小轮播",@"有边距轮播",@"BarTab"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = [_tableDatas objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"小轮播"]) {
        
        BlockCollectionView *temview = [BlockCollectionView new];
        temview.isSetcenten = YES;
        temview.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
            return CGSizeMake(350, 200);
        };
        [temview setUg_numberOfItemsInSection:^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
            return 10;
        }];
        [temview setUg_cellForItemAtIndexPath:^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
            BlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            [cell.imageView sd_setImageWithURL:UGURL(@"https://github.com/UbunGit/TestImage/blob/master/animal/0.jpg?raw=true")];
            return cell;
        }];
        temview.backgroundColor = [UIColor yellowColor];
        [self.view ug_alertview:temview];
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(350);
            make.height.mas_equalTo(200);
        }];

    }else if([title isEqualToString:@"有边距轮播"]){
        
        
        BlockCollectionView *temview = [BlockCollectionView new];
        temview.isSetcenten = YES;
        temview.flowLayout.minimumLineSpacing = 10;
        temview.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
            return CGSizeMake(300, 200);
        };
        [temview setUg_numberOfItemsInSection:^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
            return 100;
        }];
        [temview setUg_cellForItemAtIndexPath:^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {

            BlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            [cell.imageView sd_setImageWithURL:UGURL(@"https://github.com/UbunGit/TestImage/blob/master/animal/0.jpg?raw=true")];
            return cell;
        }];
     
        [self.view ug_alertview:temview];
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(350);
            make.height.mas_equalTo(220);
        }];
        
        temview.backgroundColor = [UIColor whiteColor];
    }else if([title isEqualToString:@"BarTab"]){
        
        BlockCollectionView *temview = [BlockCollectionView new];
        temview.backgroundColor = [UIColor ug_R:0 G:0 B:0 A:0.7];
        [temview.collectionView registerClass:[TabbarCollectionCell class] forCellWithReuseIdentifier:@"TabbarCollectionCell"];
        [temview.collectionView registerClass:[TabbarCollectionCenCell class] forCellWithReuseIdentifier:@"TabbarCollectionCenCell"];
        
        [temview setUg_numberOfItemsInSection:^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
            return 5;
        }];
        [temview setUg_cellForItemAtIndexPath:^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
            if (indexPath.row == 2) {
                TabbarCollectionCenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TabbarCollectionCenCell" forIndexPath:indexPath];
                cell.backgroundColor = UIColor.clearColor;
                return cell;
            }else{
                TabbarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TabbarCollectionCell" forIndexPath:indexPath];
                cell.backgroundColor = UIColor.clearColor;
                return cell;
            }
        }];
        temview.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
            return CGSizeMake(350/5, 49);
        };
        temview.ug_didSelectItemAtIndexPath = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
            
        };
        
        [self.view ug_alertview:temview];
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(350);
            make.height.mas_equalTo(49);
        }];
    }
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
}
@end
