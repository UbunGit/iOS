//
//  SharesToolView.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/5.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGAlignmentButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface SharesToolView : UIView

@property(strong, nonatomic) UGAlignmentButton *addtargetbtn; // 添加指标

@property(strong, nonatomic) UGAlignmentButton *gitupbtn; // 上传

@property(strong, nonatomic) UGAlignmentButton *gitdownbtn; //下载


@end

NS_ASSUME_NONNULL_END
