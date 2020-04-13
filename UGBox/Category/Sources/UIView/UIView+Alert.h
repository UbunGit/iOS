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

//提示文字
+(void)ug_msg:(NSString*)msg;
-(void)ug_msg:(NSString*)msg;

//提示文字 结束后调用block
+(void)ug_msg:(NSString*)msg complete:(nullable AlertViewFinesh)block;
-(void)ug_msg:(NSString*)msg complete:(nullable AlertViewFinesh)block;

//提示图片
+(void)ug_alertimageType:(NSString*)imagestr;
-(void)ug_alertimageType:(NSString*)imagestr;

//提示图片 结束后调用block
+(void)ug_alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;
-(void)ug_alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;

//弹出给定的view，自带取消按钮
+(void)ug_alertview:(UIView*)aview;
-(void)ug_alertview:(UIView*)aview;

//弹出给定的view，自带取消按钮 结束后调用block
+(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;
-(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;

// loading框
+(void)ug_starloading;
-(void)ug_starloading;

+(void)ug_loadingProgress:(NSString*)string;
-(void)ug_loadingProgress:(NSString*)string;

+(void)ug_stoploading;
-(void)ug_stoploading;

// present UGPersentView
+(void)ug_persentView:(UIView*)customView;
-(void)ug_persentView:(UIView*)customView;

+(void)ug_dismisPersentView;
-(void)ug_dismisPersentView;
@end

NS_ASSUME_NONNULL_END
