//
//  NSObject+UG.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/30.
//  Copyright © 2019 UG. All rights reserved.
//

#import "NSObject+UG.h"



@implementation NSObject (UG)

+(NSInteger)ug_randomkey:(NSInteger)length{
    NSInteger ofice = pow(10, length);
    return random() % ofice;
}

@end
