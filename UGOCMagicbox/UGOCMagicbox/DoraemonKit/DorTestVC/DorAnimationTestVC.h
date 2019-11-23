//
//  DorAnimationTestVC.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimationData : NSObject

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *des;
@property(assign, nonatomic) BOOL isselect;

@end

@interface DorAnimationTestVC : UIViewController

@end

NS_ASSUME_NONNULL_END
