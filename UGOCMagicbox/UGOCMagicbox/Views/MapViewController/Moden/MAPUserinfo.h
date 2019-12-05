//
//  Userinfo.h
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPUserinfo : RLMObject

@property NSString *name;//姓名

@property NSString *headimage;//头像

@property double latitude;//经度

@property double longitude;//纬度

@end

NS_ASSUME_NONNULL_END
