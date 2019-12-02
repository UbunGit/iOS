//
//  SharesCollectionCell.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharesTargetData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolView : UIView

@property(strong, nonatomic) UIButton *upBtn; // 涨
@property(strong, nonatomic) UIButton *downBtn; // 跌
@property(strong, nonatomic) UIButton *igoBtn; // 忽略

@end


@interface SharesCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * titleLab;
@property (strong, nonatomic) UILabel * valueLab;
@property (strong, nonatomic) ToolView * toolView;
@property (strong, nonatomic) UILabel * numberLab;

@end

NS_ASSUME_NONNULL_END
