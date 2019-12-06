//
//  UserInfo.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/5.
//  Copyright © 2019 UG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject

@property(strong, nonatomic) NSString *name; //用户名

@property(strong, nonatomic) NSString *password; //用户名

@property(strong, nonatomic) NSString *repo; // git仓库名

@property(strong, nonatomic) NSString *token; //token

@property(assign, readonly) BOOL islogin; //token

@property(assign, nonatomic) BOOL autoSave; //token defual = YES

+(instancetype)share;

-(void)clear;
@end

NS_ASSUME_NONNULL_END
