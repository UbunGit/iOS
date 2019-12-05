//
//  SharesAddView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGRemarkView.h"
#import "SharesHistoryData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SharesAddView : UIView
@property(strong, readonly) SharesHistoryData* data;

@property(strong, nonatomic) UILabel *titleLab; // 标题

@property(strong, nonatomic) UGRemarkView *titleTF; // 股票名称

@property(strong, nonatomic) UGRemarkView *numberTF; // 股票代码

@property(strong, nonatomic) UGRemarkView *timeTF; // 股票时间

@property(strong, nonatomic) UIButton *commitBtn; // 股票时间

@end

NS_ASSUME_NONNULL_END
