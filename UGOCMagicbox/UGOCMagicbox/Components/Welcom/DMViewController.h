//
//  DMViewController.h
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DMlcomBlock)( UIButton* _Nullable  sender);

@interface DMViewController : UIViewController

@property(strong, nonatomic) UIButton *cancelbtn;//跳过

@property(copy, nonatomic) DMlcomBlock endBlock;//结束lblock

@end

NS_ASSUME_NONNULL_END
