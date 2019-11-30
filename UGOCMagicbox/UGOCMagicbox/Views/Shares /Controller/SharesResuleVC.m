//
//  SharesResuleVC.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/25.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesResuleVC.h"

#import "SharesHistoryData.h"
#import "SharesTargetData.h"

@interface SharesResuleVC ()


@property(strong, nonatomic) UIButton *saveBtn;
@property(strong, nonatomic) UIButton *cancleBtn;
@property(strong,nonatomic) NSDictionary *resultDic;
@property(strong,nonatomic) BlockCollectionView *collectionView;

@end

@implementation SharesResuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.resultDic = [self calculate];
    [self.collectionView reloadData];
}
-(void)configUI{
    self.title = @"测评结果";
    // 保存
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:COLORDANGER];
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [self savedata];
    }];
    
    //放弃
    self.cancleBtn = [UIButton new];
    [self.view addSubview:_cancleBtn];
    [_cancleBtn setTitle:@"放弃返回" forState:UIControlStateNormal];
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
          [self.navigationController popToRootViewControllerAnimated:YES];
      }];
    [_cancleBtn setBackgroundColor:COLORWARNING];
    
    //
    self.collectionView = [BlockCollectionView new];
    [self.view addSubview:_collectionView];
    
    UG_WEAKSELF
    _collectionView.flowLayout.minimumLineSpacing = 0;
    _collectionView.flowLayout.minimumInteritemSpacing = 0;
    _collectionView.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.ug_numberOfItemsInSection = ^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
        return weakSelf.resultDic.allKeys.count;
    };
    _collectionView.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
       
            return CGSizeMake(KWidth/4, KWidth/4);
        
    };
    _collectionView.ug_cellForItemAtIndexPath = ^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
         BlockCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [cell ug_borderColor:COLOR23 width:0.5];
        NSString *key = [weakSelf.resultDic.allKeys objectAtIndex:indexPath.row];
        NSArray *temarr = [weakSelf.resultDic objectForKey:key];
        cell.titleLab.text = [NSString stringWithFormat:@"%@\n%zd",key,temarr.count];
        return cell;
    };
}


-(void)savedata{
    NSString *savestr = [_editDic jsonStringEncoded];
    DDLogVerbose(@"%@",savestr);
    NSString *fileName = _sharesdata.number;
    NSString *lpath = [NSString stringWithFormat:@"%zd",_sharesdata.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"/shares/%@",lpath];
    
    NSString *filePaths =  [NSString stringWithFormat:@"%@/%@.json",path,fileName];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:filePaths error:nil];
    [defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSError *err = [NSError new];
    BOOL isok =[savestr writeToFile:filePaths atomically:YES encoding:NSUTF8StringEncoding error:&err];
    
    if (isok) {
        SharesHistoryData *data = [SharesHistoryData new];
        data.edittime = [[NSDate date] timeIntervalSince1970];
        data.date = _sharesdata.date;
        data.number = _sharesdata.number;
        data.path = @"/shares";
        data.name = _sharesdata.name;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:data];
            [self.view ug_msg:@"保存成功"];
        }];
        
    }else{
        [self.view ug_msg:@"保存失败"];
    }
}

-(NSDictionary *)calculate{
    
    NSMutableDictionary *remarkDic = [NSMutableDictionary new];
    for (SharesTargetData *data in [SharesTargetData allObjects]) {
        
        //获取该指标下股票的测评内容
        NSString *value = [_editDic objectForKey:data.key];
        
        // 总数组添加
        NSMutableArray *dataarr = [remarkDic objectForKey:@"all"];
        if (!dataarr) {
            dataarr = [NSMutableArray new];
        }
        [dataarr addObject:value];
        
        for (NSString *remark in [data.remark componentsSeparatedByString:@","]) {
            NSMutableArray *dataarr = [remarkDic objectForKey:remark];
            if (!dataarr) {
                dataarr = [NSMutableArray new];
            }
            [dataarr addObject:value];
        }
    }
    return remarkDic;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
    }];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
          make.left.mas_equalTo(self.view.mas_centerX);
          make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
      }];
}
@end
