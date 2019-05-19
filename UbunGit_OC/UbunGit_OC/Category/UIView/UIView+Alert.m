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
#import "Masonry.h"

#include <objc/runtime.h>

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@implementation UIView (Alert)

+(void)alert:(NSString*)msg{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alert:msg];
}
+(void)alert:(NSString*)msg complete:(AlertViewFinesh)block{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alert:msg complete:block];
}

+(void)alertimageType:(NSString*)imagestr{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alertimageType:imagestr];
    
}

+(void)alertimageType:(NSString*)imagestr complete:(AlertViewFinesh)block{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window alertimageType:imagestr complete:block];
}



-(void)alert:(NSString*)msg{
    [self alert:msg complete:nil];
}

-(void)alert:(NSString*)msg complete:(nullable AlertViewFinesh)block{
    dispatch_main_async_safe(^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.label.text = msg;
        hud.label.textColor = [UIColor whiteColor];
        [hud hideAnimated:YES afterDelay:1.75];
        objc_setAssociatedObject(self, "finishedblock", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self performSelector:@selector(finishedblockDoit) withObject:nil afterDelay:1.75];
    });
}

-(void)alertimageType:(NSString*)imagestr{
    [self alertimageType:imagestr complete:nil];
}

-(void)alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block{
    dispatch_main_async_safe(^{
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagestr]];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = imageView;
        hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        objc_setAssociatedObject(self, "finishedblock", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self performSelector:@selector(finishedblockDoit) withObject:nil afterDelay:1.75];
        [hud hideAnimated:YES afterDelay:1.75];
    });
}

-(void)finishedblockDoit{
    AlertViewFinesh block = objc_getAssociatedObject(self, "finishedblock");
    if (block) {
        block(YES);
    }
}

//弹出给定的view，自带取消按钮
+(void)ug_alertview:(UIView*)aview{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_alertview:aview complete:nil];
}
+(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_alertview:aview complete:block];
}

//弹出给定的view，自带取消按钮
-(void)ug_alertview:(UIView*)aview{
    [self ug_alertview:aview complete:nil];
}
-(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block{
    
    UIView *cancelview = [UIView new];
    [cancelview addSubview:aview];
    
    UIButton *abutton = [UIButton new];
    [cancelview addSubview:abutton];
    [abutton setTitle:@"关闭" forState:UIControlStateNormal];

    cancelview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    abutton.backgroundColor = [UIColor redColor];
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = cancelview;
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    
    [abutton ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [hud hideAnimated:YES afterDelay:0.2];
    }];
    [cancelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(aview);
    }];
    [aview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancelview);
        make.left.right.mas_equalTo(cancelview);
    }];
    [abutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aview.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(cancelview);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(cancelview);
    }];
    
}


+(void)starloading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window starloading];
}
+(void)stoploading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window stoploading];
}
static MBProgressHUD *loadinghud = nil;
-(void)starloading{
    dispatch_main_async_safe(^{
        loadinghud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        loadinghud.mode = MBProgressHUDModeIndeterminate;
    });
}
-(void)stoploading{
    dispatch_main_async_safe(^{
        [loadinghud hideAnimated:YES];
    });
}

@end
