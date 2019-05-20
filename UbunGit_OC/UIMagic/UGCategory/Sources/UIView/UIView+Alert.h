//
//  UIView+Alert.h
//  UbunGit_OC
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN


typedef void(^AlertViewFinesh)(BOOL finished);

@interface UIView (Alert)

+(void)alert:(NSString*)msg;
+(void)alert:(NSString*)msg complete:(nullable AlertViewFinesh)block;

+(void)alertimageType:(NSString*)imagestr;
+(void)alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;



-(void)alert:(NSString*)msg;
-(void)alert:(NSString*)msg complete:(nullable AlertViewFinesh)block;

-(void)alertimageType:(NSString*)imagestr;
-(void)alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;

//弹出给定的view，自带取消按钮
+(void)ug_alertview:(UIView*)aview;
+(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;

//弹出给定的view，自带取消按钮
-(void)ug_alertview:(UIView*)aview;
-(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;


+(void)starloading;
+(void)stoploading;

-(void)starloading;
-(void)stoploading;

@end

NS_ASSUME_NONNULL_END
