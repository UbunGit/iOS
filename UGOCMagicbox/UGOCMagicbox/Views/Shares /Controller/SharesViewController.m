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

@interface SharesViewController ()
@property(strong,nonatomic)BlockCollectionView *collectionView;
@property(strong, nonatomic)RLMResults<SharesTargetData *> *datalist;
@property(strong, nonatomic)NSMutableDictionary *editDic;
@end

@implementation SharesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.editDic = [NSMutableDictionary new];
    [self updataData];
}


-(void)updataData{
   
    self.datalist = [SharesTargetData allObjects];
    [_collectionView reloadData];
}
-(void)configUI{
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
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
    
    UG_WEAKSELF
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
        [cell.toolView.upBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [weakSelf.editDic setObject:@100 forKey:data.title];
            cell.valueLab.text =[NSString stringWithFormat:@"%@",[weakSelf.editDic objectForKey:data.title]];
        }];
        [cell.toolView.downBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [weakSelf.editDic setObject:@0 forKey:data.title];
            cell.valueLab.text =[NSString stringWithFormat:@"%@",[weakSelf.editDic objectForKey:data.title]];
        }];
        [cell.toolView.igoBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [weakSelf.editDic setObject:@50 forKey:data.title];
            cell.valueLab.text =[NSString stringWithFormat:@"%@",[weakSelf.editDic objectForKey:data.title]];
        }];
        return cell;
    };
    
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
@end
