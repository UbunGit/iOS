//
//  UIControl+UG.m
//  LHCloud
//
//  Created by admin on 2019/5/9.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UIControl+UG.h"
#import <objc/runtime.h>

static char * const ug_buttonBlockKey = "ug_buttonBlockKey";
static char * const ug_eventIntervalKey = "ug_eventIntervalKey";
static char * const ug_eventUnavailableKey = "ug_eventUnavailableKey";

@interface UIControl ()

@property (nonatomic, assign) BOOL ug_eventUnavailable;

@end
@implementation UIControl (UG)


+ (void)load {
    
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method ug_method = class_getInstanceMethod(self, @selector(ug_sendAction:to:forEvent:));
    method_exchangeImplementations(method, ug_method);
}

-(void)ug_addEvents:(UIControlEvents)event andBlock:(ug_ButtonActionBlock)block{
    
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:event];
    
    objc_setAssociatedObject(self, ug_buttonBlockKey, block, OBJC_ASSOCIATION_COPY);
    
}

-(void)ug_addEvents:(UIControlEvents)event eventInterval:(NSTimeInterval)eventInterval andBlock:(ug_ButtonActionBlock)block{
    [self setUg_eventInterval:eventInterval];
    [self ug_addEvents:event andBlock:block];
}


-(void)buttonClicked:(UIButton *)sender{
    
    ug_ButtonActionBlock block=objc_getAssociatedObject(sender, ug_buttonBlockKey);
    if(block){
        block(sender);
    }
}

- (void)ug_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.ug_eventUnavailable == NO) {
        self.ug_eventUnavailable = YES;
        [self ug_sendAction:action to:target forEvent:event];
        [self performSelector:@selector(setUg_eventUnavailable:) withObject:@(NO) afterDelay:self.ug_eventInterval];
    }
}


#pragma mark - Setter & Getter functions

- (NSTimeInterval)ug_eventInterval {
    
    return [objc_getAssociatedObject(self, ug_eventIntervalKey) doubleValue];
}

- (void)setUg_eventInterval:(NSTimeInterval)ug_eventInterval {
    
    objc_setAssociatedObject(self, ug_eventIntervalKey, @(ug_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ug_eventUnavailable {
    
    return [objc_getAssociatedObject(self, ug_eventUnavailableKey) boolValue];
}

- (void)setUg_eventUnavailable:(BOOL)ug_eventUnavailable{
    
    objc_setAssociatedObject(self, ug_eventUnavailableKey, @(ug_eventUnavailableKey), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
