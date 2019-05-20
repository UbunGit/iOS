//
//  UITextView+WY_Extension.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import "UITextView+WY_Extension.h"
#import "Masonry.h"
#include <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, assign) BOOL wy_addNoti;

@property (nonatomic, copy) NSString *wy_lastTextStr;

@property (nonatomic, copy) void(^wy_textHandle) (NSString *textStr);

@property (nonatomic, weak) UILabel *wy_placeholderLable;

@property (nonatomic, weak) UILabel *wy_charactersLengthLable;

@end

@implementation UITextView (WY_Extension)

- (void)setWy_addNoti:(BOOL)wy_addNoti {
    
    objc_setAssociatedObject(self, &@selector(wy_addNoti), [NSNumber numberWithBool:wy_addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wy_addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(wy_addNoti)) boolValue];
    return obj;
}

- (void)setWy_placeholderStr:(NSString *)wy_placeholderStr {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderStr), wy_placeholderStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self wy_fixMessyDisplay];
    self.wy_placeholderLable.backgroundColor = [UIColor clearColor];
}

- (NSString *)wy_placeholderStr {
    
    NSString *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderStr));
    return obj;
}

- (void)setWy_placeholderColor:(UIColor *)wy_placeholderColor {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderColor), wy_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self wy_fixMessyDisplay];
    self.wy_placeholderLable.backgroundColor = [UIColor clearColor];;
}

- (UIColor *)wy_placeholderColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderColor));
    return obj;
}

- (void)setWy_placeholderFont:(UIFont *)wy_placeholderFont {
    
    objc_setAssociatedObject(self, &@selector(wy_placeholderFont), wy_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.wy_placeholderLable.backgroundColor = [UIColor clearColor];
}

- (UIFont *)wy_placeholderFont {
    
    UIFont *obj = objc_getAssociatedObject(self, &@selector(wy_placeholderFont));
    return obj;
}

- (void)setWy_maximumLimit:(NSInteger)wy_maximumLimit {
    
    objc_setAssociatedObject(self, &@selector(wy_maximumLimit), [NSNumber numberWithInteger:wy_maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    [self wy_fixMessyDisplay];
}

- (NSInteger)wy_maximumLimit {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_maximumLimit));
    return [obj integerValue];
}



- (BOOL)wy_characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, &@selector(wy_characterLengthPrompt));
    return [obj boolValue];
}

- (UILabel *)wy_placeholderLable {
    
    UILabel *obj = objc_getAssociatedObject(self, @selector(wy_placeholderLable));
    if(obj == nil) {
        
        obj = [[UILabel alloc]init];
        obj.numberOfLines = 0;
        obj.userInteractionEnabled = NO;
        [self insertSubview:obj atIndex:0];
        objc_setAssociatedObject(self, @selector(wy_placeholderLable), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(5.0);
            make.top.mas_equalTo(self).mas_offset(8.0);
            make.right.mas_equalTo(self).mas_offset(5.0);
        }];
    }
    
    obj.font = self.wy_placeholderFont ? self.wy_placeholderFont : self.font;
    obj.textColor = self.wy_placeholderColor ? self.wy_placeholderColor : [UIColor lightGrayColor];
    obj.text = self.wy_placeholderStr;
    [obj sizeToFit];
    
    return obj;
}



- (void)setWy_textHandle:(void (^)(NSString *))wy_textHandle {
    
    objc_setAssociatedObject(self, &@selector(wy_textHandle), wy_textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))wy_textHandle {
    
    id handle = objc_getAssociatedObject(self, &@selector(wy_textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setWy_lastTextStr:(NSString *)wy_lastTextStr {
    
    objc_setAssociatedObject(self, @selector(wy_lastTextStr), wy_lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)wy_lastTextStr {
    NSString *str = objc_getAssociatedObject(self, _cmd);
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;

}

- (void)wy_textDidChange:(void (^)(NSString * _Nonnull))handle {
    
    self.wy_textHandle = handle;
    [self wy_fixMessyDisplay];
}

- (void)wy_fixMessyDisplay {
    
    if(self.wy_maximumLimit <= 0) {self.wy_maximumLimit = MAXFLOAT;}
    [self wy_addTextChangeNoti];
}

- (void)wy_textDidChange {
    
    [self wy_characterTruncation];
}

- (void)wy_characterTruncation {
    
    //字符截取
    if(self.wy_maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.wy_maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.wy_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.wy_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.wy_maximumLimit];
            }
        }
    }
    
    if((self.wy_textHandle) && (![self.text isEqualToString:self.wy_lastTextStr])) {
        
        self.wy_textHandle(self.text);
    }
    self.wy_lastTextStr = self.text;
    
    self.wy_placeholderLable.hidden = (self.text.length > 0) ? YES : NO;
    self.wy_charactersLengthLable.text = [NSString stringWithFormat:@"%lu/%ld\t",(unsigned long)self.text.length > (long)self.wy_maximumLimit ? (long)self.wy_maximumLimit : (unsigned long)self.text.length ,(long)self.wy_maximumLimit];
}

- (void)wy_addTextChangeNoti {
    
    if(self.wy_addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wy_textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.wy_addNoti = YES;
}



- (void)dealloc {
    
    if(self.wy_addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}

@end
