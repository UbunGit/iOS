//
//  SharesResultView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharesHistoryData.h"
#import "SharesTargetData.h"
NS_ASSUME_NONNULL_BEGIN

@interface SharesResultView : UIView

@property(strong, nonatomic)NSMutableDictionary *editDic; // 出参数
@property(strong, nonatomic)NSMutableDictionary *remarkDic; // 测评意见字典


@property(strong, nonatomic) UILabel *titleLab;
@property(strong,nonatomic) BlockCollectionView *collectionView;
@property(strong, nonatomic) SharesHistoryData* sharesdata;
 
@end

NS_ASSUME_NONNULL_END
