//
//  LocView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/7/3.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockMAMapView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocView : MAAnnotationView

@property(strong, nonnull) UILabel* titleLab;//用户名

@property(strong, nonnull) UIImageView* headImageview;//头像

@property(strong, nonnull) UIButton* clickbtn;//点击btn

@end

NS_ASSUME_NONNULL_END
