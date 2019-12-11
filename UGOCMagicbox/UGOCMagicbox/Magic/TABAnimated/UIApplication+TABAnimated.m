//
//  UIApplication+TABAnimated.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/1.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UIApplication+TABAnimated.h"

@implementation UIApplication (TABAnimated)

-(void)configTABAnimated{
    // Init `TABAnimated`, and set the properties you need.
    // 初始化TABAnimated，并设置TABAnimated相关属性
    // 初始化方法仅仅设置的是全局的动画效果
    // 你可以设置`TABViewAnimated`中局部动画属性`superAnimationType`覆盖全局属性，在工程中兼容多种动画
    [[TABAnimated sharedAnimated] initWithShimmerAnimated];
    // open log
    // 开启日志
    [TABAnimated sharedAnimated].openLog = YES;
    // set gobal cornerRadius
    [TABAnimated sharedAnimated].useGlobalCornerRadius = YES;
    // 是否开启动画坐标标记，如果开启，也仅在debug环境下有效。
    // 开启后，会在每一个动画元素上增加一个红色的数字，该数字表示该动画元素所在下标，方便快速定位某个动画元素。
    [TABAnimated sharedAnimated].openAnimationTag = DEBUG;
}
@end
