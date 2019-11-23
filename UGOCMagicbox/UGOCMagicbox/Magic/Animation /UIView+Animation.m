//
//  UIView+Animation.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//
/**
 * 动画组合
 */
#import "UIView+Animation.h"
#import <objc/runtime.h>
static char * const ug_animationfinishKey = "ug_animationfinishBlock";
@implementation UIView (Animation)


- (ug_animationfinishBlock)finishBlock{
    
    return (ug_animationfinishBlock) objc_getAssociatedObject(self, ug_animationfinishKey);
}

- (void)setFinishBlock:(ug_animationfinishBlock)finishBlock{
    
    objc_setAssociatedObject(self, ug_animationfinishKey, finishBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 * 图片y，centenX不变，缩小到一定比例
 */
-(void)ug_animationflashwithBlock:(ug_animationfinishBlock)finishBlock{
    [self setNeedsLayout];
    [self bk_performBlock:^(id obj) {
          self.transform = CGAffineTransformMakeScale(1, 1);
          
          CABasicAnimation * scaleAnim = [CABasicAnimation animation];
          scaleAnim.keyPath = @"transform.scale";
          scaleAnim.fromValue = @1;
          scaleAnim.toValue = @0.2;
          scaleAnim.duration = 2;
         
          /// 路径动画
          UIBezierPath *pathAnim = [UIBezierPath bezierPath];
          [pathAnim moveToPoint:self.layer.position];
          [pathAnim addQuadCurveToPoint:CGPointMake(self.center.x, self.frame.origin.y) controlPoint:self.center];
          CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
          pathAnimation.path = pathAnim.CGPath;
          
        
          [self ug_animationGroup:@[scaleAnim, pathAnimation] time:2 Block:finishBlock];
    } afterDelay:0.1];

}

/**
 * 路径移动，需要的时候修改里面参数
 */
-(void)ug_animationPathwithBlock:(ug_animationfinishBlock)finishBlock{
    
    [self setNeedsLayout];
       [self bk_performBlock:^(id obj) {
     
             /// 路径动画
             UIBezierPath *pathAnim = [UIBezierPath bezierPath];
             [pathAnim moveToPoint:self.layer.position];
             [pathAnim addQuadCurveToPoint:CGPointMake(self.center.x, KHeight) controlPoint:self.center];
             CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
             pathAnimation.path = pathAnim.CGPath;
             
           
             [self ug_animationGroup:@[pathAnimation] time:0.75 Block:finishBlock];
       } afterDelay:0.1];
    
}

-(void)ug_animationshakewithBlock:(ug_animationfinishBlock)finishBlock{
    
    CGFloat duration = 0.7f;
    CGFloat height = 25.f;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTy = self.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = 1;
    [self ug_animationGroup:@[animation] time:0.75 Block:finishBlock];
}

/*
 * 播放动画组
 */
-(void)ug_animationGroup:(NSArray<CAAnimation*>*)animations time:(CGFloat)time Block:(ug_animationfinishBlock)finishBlock{
    
    if (finishBlock) {
         [self setFinishBlock:finishBlock];
     }
  
    CAAnimationGroup *groups = [CAAnimationGroup animation];
         groups =[CAAnimationGroup animation];
         groups.animations = animations;
         groups.removedOnCompletion = NO;
         groups.fillMode = kCAFillModeForwards;
         groups.duration = time;
         groups.delegate = self;
         
         [self.layer addAnimation:groups forKey:@"group"];

}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (self.finishBlock) {
        self.finishBlock(YES,anim);
    }
//    [self.layer removeAnimationForKey:@"group"];
    
}

@end
