//
//  MessageCenter.m
//  LHCloud
//
//  Created by admin on 2019/3/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import "MessageCenter.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#define UGIMAGE(str) [UIImage imageNamed:str]
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif


@implementation MessageCenter

+(void)alert:(NSString*)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:3.f];
}


+(void)alertimageYype:(NSString*)msg{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:UGIMAGE(msg)];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.customView = imageView;
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:3.f];
}

+(void)starloading{
    dispatch_main_async_safe(^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
    });
}
+(void)stoploading{
    dispatch_main_async_safe(^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}
@end
