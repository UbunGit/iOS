//
//  DanMushowView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCBarrage.h"
#import "DanmuManCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DanMushowView : UIView

@property(strong, nonatomic) NSMutableArray *listarr; // 排队数组
@property(strong, readonly) NSMutableArray *showarr; // 显示的数组

@property (nonatomic, strong) OCBarrageManager *barrageManager;


@end

NS_ASSUME_NONNULL_END
