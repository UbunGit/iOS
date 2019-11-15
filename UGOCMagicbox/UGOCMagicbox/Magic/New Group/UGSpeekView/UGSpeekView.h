//
//  UGSpeekView.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGWaverView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UGSpeekView : UIView

@property (nonatomic, strong) UIImageView *cenImageView; //中间圆形图片
@property (nonatomic, strong) UIButton *closeBtn; // 关闭按钮

@property (nonatomic, strong) UGWaverView *waverView; //水波view

@property (nonatomic, strong) UIView *contentView; //内容view

@end

NS_ASSUME_NONNULL_END
