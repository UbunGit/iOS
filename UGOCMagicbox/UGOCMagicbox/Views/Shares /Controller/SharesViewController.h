//
//  SharesViewController.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharesSimpleData.h"
NS_ASSUME_NONNULL_BEGIN

@interface SharesViewController : SupleViewController
@property(strong, nonatomic) SharesSimpleData* sharesdata;
@property(strong, nonatomic)NSMutableDictionary *editDic;
@end

NS_ASSUME_NONNULL_END
