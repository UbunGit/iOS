//
//  UIView+Alert.h
//  UbunGit_OC
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (Alert)

+(void)alert:(NSString*)msg;
+(void)alertimageType:(NSString*)imagestr;

+(void)starloading;
+(void)stoploading;

-(void)alert:(NSString*)msg;
-(void)alertimageType:(NSString*)imagestr;

-(void)starloading;
-(void)stoploading;
@end

NS_ASSUME_NONNULL_END
