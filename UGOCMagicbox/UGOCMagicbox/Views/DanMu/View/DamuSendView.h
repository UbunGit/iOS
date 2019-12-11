//
//  DamuSendView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlockCollectionView.h"

NS_ASSUME_NONNULL_BEGIN
@interface DamuHeadView : UIView

@property(strong, nonatomic) UGImageView *headImageView; //头像

@property(strong, nonatomic) UIImageView *remarkImageView; //贴纸

@end

@interface DamuHeadCell :UICollectionViewCell

@property(strong, nonatomic) DamuHeadView *headView; //头像

@end

@interface DamuInputView : UIView

@property(strong, nonatomic) UGTextField *textField; //输入框

@property(strong, nonatomic) UIButton *sendBtn; //发送按钮

@end

@interface DamuSendView : UIView

@property(strong, nonatomic) DamuHeadView *headView; //头像

@property(strong, nonatomic) UIView *contentView; //白色背景view

@property(strong, nonatomic) DamuInputView *inputView; //输入框

@property(strong, nonatomic) UILabel *titleLab; //标题文字

@property(strong, nonatomic) BlockCollectionView *collectionView; //贴纸选项卡
@property(assign, nonatomic) NSIndexPath* selectdata; //选中的

@end

NS_ASSUME_NONNULL_END
