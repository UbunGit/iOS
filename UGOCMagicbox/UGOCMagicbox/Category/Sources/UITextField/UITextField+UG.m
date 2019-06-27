//
//  UITextField+UG.m
//  LHCloud
//
//  Created by admin on 2019/3/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UITextField+UG.h"
#include <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, assign) BOOL ug_addNoti;

@property (nonatomic, copy) NSString *ug_lastTextStr;

@property (nonatomic, copy) void(^ug_textHandle) (NSString *textStr);

@end


@implementation UITextField (UG)



- (void)setUg_addNoti:(BOOL)ug_addNoti {
    
    objc_setAssociatedObject(self, @selector(ug_addNoti), [NSNumber numberWithBool:ug_addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ug_addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setUg_maximumLimit:(NSInteger)ug_maximumLimit {
    
    objc_setAssociatedObject(self, @selector(ug_maximumLimit), @(ug_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    
    [self ug_fixMessyDisplay];
}

- (NSInteger)ug_maximumLimit {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setUg_textHandle:(void (^)(NSString *))ug_textHandle {
    
    objc_setAssociatedObject(self, @selector(ug_textHandle), ug_textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))ug_textHandle {
    
    return objc_getAssociatedObject(self, @selector(ug_textHandle));
}

- (void)setUg_lastTextStr:(NSString *)ug_lastTextStr {
    
    objc_setAssociatedObject(self, @selector(ug_lastTextStr), ug_lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)ug_lastTextStr {
    NSString *str = objc_getAssociatedObject(self, _cmd);
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
    
}

/**
 *  监听文字改变
 */
- (void)ug_textDidChange {
    
    [self ug_characterTruncation];
}

- (void)ug_textDidChange:(void (^)(NSString * _Nonnull))handle {
    
    self.ug_textHandle = handle;
    [self ug_fixMessyDisplay];
}

- (void)ug_fixMessyDisplay {
    
    if(self.ug_maximumLimit <= 0) {self.ug_maximumLimit = MAXFLOAT;}
    [self ug_addTextChangeNoti];
}

- (void)ug_addTextChangeNoti {
    
    if(self.ug_addNoti == NO) {
        
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ug_textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.ug_addNoti = YES;
}

- (NSString *)ug_characterTruncation {
    
    //字符截取
    if(self.ug_maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.ug_maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.ug_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.ug_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.ug_maximumLimit];
            }
        }
    }
    if((self.ug_textHandle) && (![self.text isEqualToString:self.ug_lastTextStr])) {
        
        self.ug_textHandle(self.text);
    }
    self.ug_lastTextStr = self.text;
    
    return self.text;
}

- (void)dealloc {
    
    if(self.ug_addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}


@end
