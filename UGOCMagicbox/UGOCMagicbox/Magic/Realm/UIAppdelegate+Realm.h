//
//  UIAppdelegate+Realm.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/30.
//  Copyright © 2019 UG. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Realm)

-(void)configRealm:(NSURL*)path;

-(NSString*)getsha;

-(NSString*)getDownurl;

/**
 更新 realm 文件信息，下载路径，sha 等
 */
-(void)updateRealInfo:(void(^)(NSError*error,NSDictionary*result))endblock;


@end

NS_ASSUME_NONNULL_END
