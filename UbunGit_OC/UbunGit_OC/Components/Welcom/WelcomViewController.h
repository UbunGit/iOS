//
//  WelcomViewController.h
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WelcomBlock)( UIButton* _Nullable  sender);

@interface WelcomViewController : UIViewController


@property(strong, nonatomic) UIScrollView *scrollerView;//图片轮播

@property(strong, nonatomic) UIButton *welcombtn;//立即体验

@property(strong, nonatomic) UIButton *cancelbtn;//跳过

@property(strong, nonatomic) UIPageControl *pageControl;//点点

@property(strong, nonatomic) NSArray *imageArr;//图片数组

@property(copy, nonatomic) WelcomBlock endBlock;//结束lblock

@end

NS_ASSUME_NONNULL_END
