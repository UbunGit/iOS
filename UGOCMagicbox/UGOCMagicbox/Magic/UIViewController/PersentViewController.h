//
//  PersentViewController.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface PersentViewController : UIViewController

@property(assign, nonatomic) NSInteger type; // 0 居中 1局下

@property(strong, nonatomic)UIView *cotentView;

@property(strong, nonatomic)UIButton *closeBtn;

@end

NS_ASSUME_NONNULL_END
