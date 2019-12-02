//
//  SharesViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesViewController.h"

#import "SharesTargetSettingVC.h"
#import "SharesCollectionCell.h"
#import "SharesResuleVC.h"

@interface SharesViewController ()

@property(strong,nonatomic)BlockCollectionView *collectionView;
@property(strong,nonatomic)UIButton *commitBtn;
@property(strong, nonatomic)RLMResults<SharesTargetData *> *datalist;


@end

@implementation SharesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_editDic) {
        self.editDic = [NSMutableDictionary new];
    }
    
    [self updataData];
}
-(void)setEditDic:(NSMutableDictionary *)editDic{
    if (![editDic isKindOfClass:[NSMutableDictionary class]]) {
        _editDic = [NSMutableDictionary dictionaryWithDictionary:editDic];
    }else{
        _editDic = editDic; 
    }
}


-(void)updataData{
   
    self.datalist = [SharesTargetData allObjects];
    [_collectionView reloadData];
}
-(void)configUI{
     UG_WEAKSELF
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.title = [NSString stringWithFormat:@"%@(%zd)",_sharesdata.name,_sharesdata.date];
    //导航拦
    UIButton *itemButtom = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    
    [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        SharesTargetSettingVC *vc = [SharesTargetSettingVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
    [self.navigationItem setRightBarButtonItems:@[button]];
    
    self.collectionView = [BlockCollectionView new];
    [self.view addSubview:_collectionView];

    _collectionView.flowLayout.minimumLineSpacing = 0;
    _collectionView.flowLayout.minimumInteritemSpacing = 0;
    [_collectionView registerClass:[SharesCollectionCell class] forCellWithReuseIdentifier:@"SharesCollectionCell"];
    _collectionView.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.ug_numberOfItemsInSection = ^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
        return weakSelf.datalist.count;
    };
    _collectionView.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
       
            return collectionView.bounds.size;
        
    };
    _collectionView.ug_cellForItemAtIndexPath = ^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        SharesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharesCollectionCell" forIndexPath:indexPath];
        SharesTargetData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
       
        if ([weakSelf.editDic objectForKey:data.title]) {
            cell.valueLab.text =[NSString stringWithFormat:@"%@",[weakSelf.editDic objectForKey:data.title]];
        }
        cell.titleLab.text = [NSString stringWithFormat:@"%@",data.title];
        cell.numberLab.text = [NSString stringWithFormat:@"%zd/%zd",indexPath.row+1,weakSelf.datalist.count];
        [cell reloadData:data];
       
        __weak typeof(cell) weakcell = cell;
        cell.toolView.blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            SharesTargetOption *data = [weakcell.toolView.datalist objectAtIndex:indexPath.row];
            weakcell.toolView.selectData = data;
            [weakcell.toolView.blockTableView reloadData];
            weakcell.valueLab.text = data.value;
            [weakSelf.editDic setObject:@100 forKey:data.key];
             [weakSelf cellHandleEnd:indexPath];
        };
        return cell;
    };
    
    self.commitBtn = [UIButton new];
    [self.view addSubview:_commitBtn];
    [_commitBtn setBackgroundColor:[UIColor ug_random]];
    [_commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
       
    }];
}

-(void)cellHandleEnd:(NSIndexPath *)indexPath{
    if (indexPath.row == _datalist.count-1) {
        SharesResuleVC *sharesResuleVC = [SharesResuleVC new];
        sharesResuleVC.sharesdata = _sharesdata;
        sharesResuleVC.editDic = _editDic;
        [self.navigationController pushViewController:sharesResuleVC animated:YES];
    }
    
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
@end
