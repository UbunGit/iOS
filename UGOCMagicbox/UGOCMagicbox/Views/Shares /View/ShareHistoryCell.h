//
//  ShareHistoryCell.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/4.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SharesHistoryData.h"
#import "UGKeyValueView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareHistoryCell : UITableViewCell

@property(strong, nonatomic) UILabel *titlelab; //股票名称跟编号

@property(strong, nonatomic) UGKeyValueView *timelab; //评测时间

@property(strong, nonatomic) UILabel *handleTimelab; // 建议操作时间
@property(strong, nonatomic) UILabel *priceinlab; // 买入价
@property(strong, nonatomic) UILabel *priceoutlab; // 卖出价
@property(strong, nonatomic) UILabel *remarklab; // 评测意见

-(void)reload:(SharesHistoryData*)data;
@end

NS_ASSUME_NONNULL_END
