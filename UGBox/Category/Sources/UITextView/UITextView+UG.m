//
//  UITextView+UG.m
//  WYBasisKit
//
//  Created by  admin on 2018/11/27.
//  Copyright © 2018 admin. All rights reserved.
//

#import "UITextView+UG.h"
#include <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

@end

@implementation UITextView (UG)

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, &@selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(addNoti)) boolValue];
    return obj;
}

- (void)setUg_placeholderStr:(NSString *)ug_placeholderStr{
    
    objc_setAssociatedObject(self, &@selector(ug_placeholderStr), ug_placeholderStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (NSString *)ug_placeholderStr {
    
    NSString *obj = objc_getAssociatedObject(self, &@selector(ug_placeholderStr));
    return obj;
}

- (void)setUg_placeholderColor:(UIColor *)ug_placeholderColor {
    
    objc_setAssociatedObject(self, &@selector(ug_placeholderColor), ug_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
}

- (UIColor *)ug_placeholderColor {
    
    UIColor *obj = objc_getAssociatedObject(self, &@selector(ug_placeholderColor));
    return obj;
}

- (void)setUg_maximumLimit:(NSInteger)ug_maximumLimit{
    
    objc_setAssociatedObject(self, &@selector(ug_maximumLimit), [NSNumber numberWithInteger:ug_maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (NSInteger)ug_maximumLimit {
    
    id obj = objc_getAssociatedObject(self, &@selector(ug_maximumLimit));
    return [obj integerValue];
}

- (void)setUg_characterLengthPrompt:(BOOL)ug_characterLengthPrompt{
    
    objc_setAssociatedObject(self, &@selector(ug_characterLengthPrompt), [NSNumber numberWithBool:ug_characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (BOOL)ug_characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, &@selector(ug_characterLengthPrompt));
    return [obj boolValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, &@selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    id handle = objc_getAssociatedObject(self, &@selector(textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    
    return [NSString emptyStr:objc_getAssociatedObject(self, _cmd)];
}

- (void)ug_textDidChange:(void (^)(NSString *))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

- (void)ug_fixMessyDisplay {
    
    if(self.ug_maximumLimit <= 0) {self.ug_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

/**
 *  监听文字改变
 */
- (void)ug_textDidChange {
    
    //重绘
    [self characterTruncation];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //设置文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.ug_placeholderColor ? self.ug_placeholderColor : [UIColor lightGrayColor];
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width -2 * x;
    
    //画最大字符文本,添加文本显示边界
    if((self.ug_maximumLimit > 0) && (self.ug_characterLengthPrompt == YES)) {
        
        [self setContentInset:UIEdgeInsetsMake(0, 0, 25, 0)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentRight;
        
        NSMutableDictionary *maximumLimitAttributes = [attributes mutableCopy];
        maximumLimitAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
        
        NSString *limitStr = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length > (long)self.ug_maximumLimit ? (long)self.ug_maximumLimit : (unsigned long)self.text.length ,(long)self.ug_maximumLimit];
        
        [limitStr drawInRect:CGRectMake(x, rect.size.height-20+self.contentOffset.y, width, 20) withAttributes:maximumLimitAttributes];
    }
    //如果不需要显示最大字符限制文本，则把边界置为默认
    else {
        
        [self setContentInset:UIEdgeInsetsZero];
    }
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    //画文字
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    [self.ug_placeholderStr drawInRect:placeholderRect withAttributes:attributes];
}

- (void)characterTruncation {
    
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
    
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ug_textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}

@end
