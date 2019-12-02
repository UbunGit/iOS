//
//  TargetOptionAddView.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/12/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UGRemarkView.h"
#import "SharesTargetData.h"
NS_ASSUME_NONNULL_BEGIN

@interface TargetOptionAddView : UIView

@property(strong, nonatomic) UILabel *titleLab; // 标题
@property(strong, nonatomic) UGRemarkView *titleTF;
@property(strong, nonatomic) UGRemarkView *remarkTV;
@property(strong, nonatomic) UGRemarkView *valueTV;
@property(strong, nonatomic) UIButton *commitBtn; // 股票时间


@property(strong, nonatomic, nullable) SharesTargetOption *editData;

@end

NS_ASSUME_NONNULL_END
