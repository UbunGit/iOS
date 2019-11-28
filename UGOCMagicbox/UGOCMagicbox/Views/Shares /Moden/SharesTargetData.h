//
//  SharesTargetData.h
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN
/**
 测评标准
 */
@interface SharesTargetData : RLMObject

@property(strong, nonatomic) NSString *title;

@property(strong, nonatomic) NSString *remark;

@property(strong, nonatomic) NSString *cotent;

+(void)install;

@end

NS_ASSUME_NONNULL_END
