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

@property(strong, nonatomic)BlockTableView *blockTableView;

@property(strong, nonatomic) NSString *key;
@property(strong, nonatomic) RLMResults <SharesTargetOption*>*datalist;
@property(strong, nonatomic) SharesTargetOption *selectData;
@end


@interface SharesCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * titleLab;
@property (strong, nonatomic) UILabel * valueLab;
@property (strong, nonatomic) ToolView * toolView;
@property (strong, nonatomic) UILabel * numberLab;

-(void)reloadData:(SharesTargetData*)data;

@end

NS_ASSUME_NONNULL_END
