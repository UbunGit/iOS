//
//  UGKeyValueView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UGKeyValueView : UIView
/**
 两个lab 分别是 标题，内容view
 */
@property(assign, nonatomic) CGFloat panding; // 标题与文字之间的间距

@property(assign, nonatomic) UIEdgeInsets edge; //边距

@property(strong, nonatomic) NSString *key; // 标题文字

@property(strong, nonatomic) NSString *vlaue; // 内容文字

@property(strong, nonatomic) UILabel *keylab; // 标题文字lab

@property(strong, nonatomic) UILabel *valuelab; // 内容文字 lab

@end

NS_ASSUME_NONNULL_END
