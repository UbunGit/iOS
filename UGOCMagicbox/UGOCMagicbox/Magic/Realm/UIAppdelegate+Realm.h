//
//  UIAppdelegate+Realm.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/30.
//  Copyright © 2019 UG. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Realm)

-(void)configRealm;

-(NSString*)getsha;

/**
 更新 realm 文件信息，下载路径，sha 等
 */
-(void)updateRealInfo;


@end

NS_ASSUME_NONNULL_END
