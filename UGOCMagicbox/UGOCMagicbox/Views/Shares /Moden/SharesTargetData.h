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
 测评选项
 */
@interface SharesTargetOption : RLMObject

@property(strong, nonatomic) NSString *key; //key

@property(strong, nonatomic) NSString *targetKey; //key

@property(strong, nonatomic) NSString *title; // 标题

@property(strong, nonatomic) NSString *remark; // 备注

@property(strong, nonatomic) NSString *value; //值
-(NSString*)makeKey;
@end
/**
 测评标准
 */
@interface SharesTargetData : RLMObject

@property(strong, nonatomic) NSString *key; //key

@property(strong, nonatomic) NSString *title; // 标题

@property(strong, nonatomic) NSString *remark; // 标签列表，","分割

@property(strong, nonatomic) NSString *cotent; // 说明文字

@property NSInteger valueType; // 值类型 0

-(NSString*)makeKey;

+(void)install;

@end

NS_ASSUME_NONNULL_END
