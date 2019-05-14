//
//  UIView+Alert.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UIView+Alert.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@implementation UIView (Alert)
+(void)alert:(NSString*)msg{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alert:msg];
}


+(void)alertimageType:(NSString*)imagestr{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alertimageType:imagestr];
}

+(void)starloading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window starloading];
}
+(void)stoploading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window stoploading];
}

-(void)alert:(NSString*)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:3.f];
}


-(void)alertimageType:(NSString*)imagestr{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagestr]];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = imageView;
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
   
//    [hud hideAnimated:YES afterDelay:3.f];
}

-(void)starloading{
    dispatch_main_async_safe(^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
    });
}
-(void)stoploading{
    dispatch_main_async_safe(^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
@end
