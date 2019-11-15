//
//  UIView+Animation.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ug_animationfinishBlock)(BOOL flag, CAAnimation* anim);

@interface UIView (Animation)<CAAnimationDelegate>



@property (nonatomic, assign) ug_animationfinishBlock finishBlock;
/**
 * 图片y，centenX不变，缩小到一定比例
 */
-(void)ug_animationflashwithBlock:(ug_animationfinishBlock)finishBlock;

/**
 * 抖动
 */
-(void)ug_animationshakewithBlock:(ug_animationfinishBlock)finishBlock;
/**
 * 路径移动，需要的时候修改里面参数
 */
-(void)ug_animationPathwithBlock:(ug_animationfinishBlock)finishBlock;
/*
 * 播放动画组
 */
-(void)ug_animationGroup:(NSArray<CAAnimation*>*)animations time:(CGFloat)time Block:(ug_animationfinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
