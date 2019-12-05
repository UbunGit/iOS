//
//  SharesResuleVC.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/25.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SharesHistoryData.h"
NS_ASSUME_NONNULL_BEGIN

@interface SharesResuleVC : SupleViewController

@property(strong, nonatomic)NSMutableDictionary *editDic;
@property(strong, nonatomic)NSMutableDictionary *remarkDic; // 测评意见字典
@property(strong, nonatomic) SharesHistoryData* sharesdata;
@end

NS_ASSUME_NONNULL_END
