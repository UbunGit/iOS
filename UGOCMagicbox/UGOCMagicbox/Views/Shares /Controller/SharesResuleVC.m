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
#import "ShareRemarkView.h"
#import "PersentViewController.h"
#import "NetWorkRequest+Shares.h"
#import "NSData+YYAdd.h"

@interface SharesResuleVC ()


@property(strong, nonatomic) UIButton *saveBtn;
@property(strong,nonatomic) NSDictionary *resultDic;
@property(strong, nonatomic) PersentViewController *persent;
@property(strong, nonatomic)ShareRemarkView *shareRemarkView;
@property(strong,nonatomic) BlockCollectionView *collectionView;
@property(strong, nonatomic) RLMResults<SharesTargetData*> *targets;
@end

@implementation SharesResuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.targets = [SharesTargetData allObjects];
    self.resultDic = [self calculate];
    [self.collectionView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self savedata];
}
-(void)configUI{
    self.title = @"测评结果";
    UG_WEAKSELF
    //关注
    UIButton *itemButtom = [UIButton  new];
    [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FAHeart];
    [itemButtom setTitle:bcaktitle forState:UIControlStateNormal];
    [itemButtom.titleLabel setFont:FONT_FA20];
    [itemButtom setTitleColor:COLORDANGER forState:UIControlStateNormal];
    [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        
    }];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
     [self.navigationItem setRightBarButtonItems:@[button]];

    
    //添加测评
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"添加测评意见" forState:UIControlStateNormal];
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
         self.persent = [PersentViewController new];
         weakSelf.persent.cotentView = self.shareRemarkView;
        [self.shareRemarkView reload:[RemarkViewValue modelWithJSON:weakSelf.remarkDic]];
         [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
      }];
    [_saveBtn ug_radius:5];
    [_saveBtn setBackgroundColor:COLORDANGER];
    
    //
    self.collectionView = [BlockCollectionView new];
    [self.view addSubview:_collectionView];
    
    _collectionView.flowLayout.minimumLineSpacing = 2;
    _collectionView.flowLayout.minimumInteritemSpacing = 2;
    _collectionView.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.flowLayout.cellType = AlignWithCenter;
    _collectionView.ug_numberOfItemsInSection = ^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
        return weakSelf.resultDic.allKeys.count;
    };
    _collectionView.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
       
            return CGSizeMake(KWidth/6, KWidth/6);
        
    };
    _collectionView.ug_cellForItemAtIndexPath = ^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
         BlockCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [cell ug_radius:KWidth/12];
        NSString *key = [weakSelf.resultDic.allKeys objectAtIndex:indexPath.row];
        NSArray *temarr = [weakSelf.resultDic objectForKey:key];
        CGFloat vgavalue = [weakSelf vlaueAvg:temarr];
        cell.titleLab.text = [NSString stringWithFormat:@"%0.2f\n%@",vgavalue,key];
        if (vgavalue>50.0) {
            cell.backgroundColor = COLORDANGER;
        }else{
            cell.backgroundColor = COLORPRIMARY;
        }
        return cell;
    };
}


-(void)savedata{
    UG_WEAKSELF
    NSMutableDictionary *savedic = [NSMutableDictionary new];
    [savedic setObject:_editDic forKey:@"data"];
    if (_remarkDic) {
        [savedic setObject:_remarkDic forKey:@"remark"];
    }
  
    NSString *savestr = [savedic jsonStringEncoded];
    NSError *err = [[NSError alloc]init];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:_sharesdata.absfilePath error:nil];
    BOOL create =[defaultManager createDirectoryAtPath:_sharesdata.abspath withIntermediateDirectories:YES attributes:nil error:&err];
    if (!create) {
        [self.view ug_msg:@"文件夹创建失败"];
        return;
    }
  
    NSString *loctpath = [NSString stringWithFormat:@"%@/%@",PATHDOCUMENT,_sharesdata.relfilepath];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:loctpath];
    NSString *oldfiledata = [data md5String];
    
    BOOL isok =[savestr writeToFile:_sharesdata.absfilePath atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (isok) {
        if (!_sharesdata.key) {
            SharesHistoryData *data = [SharesHistoryData new];
            data.key = [data makeKey];
            data.edittime = [[NSDate date] timeIntervalSince1970];
            data.date = _sharesdata.date;
            data.number = _sharesdata.number;
            data.name = _sharesdata.name;
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject: data];
                [self.view ug_msg:@"保存成功"];
            }];
             weakSelf.sharesdata = data;
        }else{
            [self.view ug_msg:@"修改成功"];
        }
        
        NSString *newfiledata = [[[NSFileManager defaultManager] contentsAtPath:_sharesdata.absfilePath] md5String];
        if (![newfiledata isEqualToString:oldfiledata]) {
            [[NetWorkRequest share] createpath:_sharesdata.relfilepath lpath:_sharesdata.relfilepath sha:_sharesdata.sha message:@"评测" block:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
                if (error) {
                    [self.view ug_msg:@"上传失败"];
                }else{
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm transactionWithBlock:^{
                        NSDictionary *dic = [dataDict objectForKey:@"content"];
                        weakSelf.sharesdata.isCommit = YES;
                        weakSelf.sharesdata.sha = [dic objectForKey:@"sha"];
                        weakSelf.sharesdata.downurl = [dic objectForKey:@"download_url"];
                        [self.view ug_msg:@"上传成功"];
                    }];
                }
            }];
        }
       

    }else{
        [self.view ug_msg:@"保存失败"];
    }
}
// 计算各指标平均值
-(CGFloat)vlaueAvg:(NSArray*)array{
    if (array.count==0) {
        return 0;
    }
    CGFloat allvalue = 0;
    for (NSString *value in array) {
        allvalue += [value floatValue];
    }
    return allvalue/array.count;
}
    
// 根据指标标示计算对应值
-(NSDictionary *)calculate{
    
    NSMutableDictionary *remarkDic = [NSMutableDictionary new];
    for (SharesTargetData *data in self.targets) {
        
        //获取该指标下股票的测评内容
        NSString *value = [_editDic objectForKey:data.key];
        if (!value) {
            continue;
        }
        // 总数组添加
        NSMutableArray *dataarr = [remarkDic objectForKey:@"综合"];
        if (!dataarr) {
            dataarr = [NSMutableArray new];
        }
        [dataarr addObject:value];
        [remarkDic setObject:dataarr forKey:@"综合"];
        for (NSString *remark in [data.remark componentsSeparatedByString:@","]) {
            NSMutableArray *dataarr = [remarkDic objectForKey:remark];
            if (!dataarr) {
                dataarr = [NSMutableArray new];
            }
            [dataarr addObject:value];
            [remarkDic setObject:dataarr forKey:remark];
        }
    }
    return remarkDic;
}
-(ShareRemarkView *)shareRemarkView{
    UG_WEAKSELF
    if (!_shareRemarkView) {
        _shareRemarkView = [ShareRemarkView new];
        [_shareRemarkView.commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            weakSelf.remarkDic = [weakSelf.shareRemarkView.value modelToJSONObject];
            [weakSelf.persent dismissViewControllerAnimated:YES completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
    }
    return _shareRemarkView;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);;
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
    }];

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.saveBtn.mas_top).mas_offset(-KPAND_DEF);
    }];
}
@end
