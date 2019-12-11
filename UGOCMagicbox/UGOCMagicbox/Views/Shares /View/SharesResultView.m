//
//  SharesResultView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesResultView.h"
@interface SharesResultView()


@property(strong,nonatomic) NSDictionary *resultDic;
@property(strong, nonatomic) RLMResults<SharesTargetData*> *targets;

@end

@implementation SharesResultView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.targets = [SharesTargetData allObjects];
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    UG_WEAKSELF
    self.backgroundColor = UIColor.whiteColor;
    self.collectionView = [BlockCollectionView new];
    [self addSubview:_collectionView];
    
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
-(void)setSharesdata:(SharesHistoryData *)sharesdata{
    _sharesdata = sharesdata;
    [self reloadUI];
    
}
-(void)reloadUI{
    NSData *filedata = [[NSFileManager defaultManager] contentsAtPath:_sharesdata.absfilePath];
    
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:filedata options:NSJSONReadingMutableLeaves error:nil];
    _editDic = [dic objectForKey:@"data"];
    _remarkDic = [dic objectForKey:@"remark"];
  
    self.resultDic = [self calculate];
    [_collectionView reloadData];
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

-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger line = _resultDic.allKeys.count/6 +_resultDic.allKeys.count%6>0?1:0;
    CGFloat height = KWidth/6 * line;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(self).mas_offset(-KPAND_DEF);
    }];
}
@end
