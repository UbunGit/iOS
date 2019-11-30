//
//  SharesTargetData.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesTargetData.h"

@implementation SharesTargetData

+(NSString *)primaryKey{
     return @"key";
}
+(void)install{
    
}
-(NSString*)makeKey{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:[date ug_formatter:@"yyyyMMddhhmmss"]];
}
@end
