//
//  UIView+Alert.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UIView+Alert.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "UGPersentView.h"

#include <objc/runtime.h>

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif
static UGPersentView *perview = nil;
@implementation UIView (Alert)

+(void)ug_msg:(NSString*)msg{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_msg:msg];
}
+(void)ug_msg:(NSString*)msg complete:(AlertViewFinesh)block{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_msg:msg complete:block];
}

+(void)ug_alertimageType:(NSString*)imagestr{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_alertimageType:imagestr];
    
}

+(void)ug_alertimageType:(NSString*)imagestr complete:(AlertViewFinesh)block{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_alertimageType:imagestr complete:block];
}



-(void)ug_msg:(NSString*)msg{
    [self ug_msg:msg complete:nil];
}

-(void)ug_msg:(NSString*)msg complete:(nullable AlertViewFinesh)block{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:1.75];
    objc_setAssociatedObject(self, "finishedblock", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self performSelector:@selector(finishedblockDoit) withObject:nil afterDelay:1.75];
    
}

-(void)ug_alertimageType:(NSString*)imagestr{
    [self ug_alertimageType:imagestr complete:nil];
}

-(void)ug_alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block{
    
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


+(void)ug_starloading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_starloading];
}
+(void)ug_loadingProgress:(NSString*)string{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_loadingProgress:string];
}

+(void)ug_stoploading{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_stoploading];
}

static MBProgressHUD *loadinghud = nil;
-(void)ug_starloading{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = 0.0;
        }];
        loadinghud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        loadinghud.mode = MBProgressHUDModeIndeterminate;
    });
    
}

-(void)ug_loadingProgress:(NSString*)string{
    dispatch_async(dispatch_get_main_queue(), ^{
        loadinghud.label.text = string;
    });
}
-(void)ug_stoploading{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        loadinghud.label.text = nil;
        [loadinghud hideAnimated:YES];
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = 1.0;
        }];
    });
}


// present UGPersentView
+(void)ug_persentView:(UIView*)customView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_persentView:customView];
}
-(void)ug_persentView:(UIView*)customView{
    if (!perview) {
        perview = [UGPersentView new];
    }
    perview.contentView = customView;
    [perview addSubview:customView];
    [self addSubview:perview];
    [perview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [customView setNeedsLayout];
    [perview setNeedsLayout];
    
    [self bk_performBlock:^(id obj) {
        
        [UIView animateWithDuration:5 animations:^{
            
            [customView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(perview.mas_bottom);
                make.left.mas_equalTo(perview);
                make.right.mas_equalTo(perview);
                make.height.mas_equalTo(300);
            }];
            
        } completion:^(BOOL finished) {
            DDLogVerbose(@"--");
        }];
        [customView setNeedsLayout];
    } afterDelay:0.2];
    
}

+(void)ug_dismisPersentView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window ug_dismisPersentView];
}
-(void)ug_dismisPersentView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [perview setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        [perview.contentView setFrame:CGRectMake(0, self.bounds.size.height, perview.contentView.bounds.size.width, perview.contentView.bounds.size.height)];
        
    } completion:^(BOOL finished) {
        [perview.contentView removeFromSuperview];
        perview.contentView = nil;
    }];
}

@end
