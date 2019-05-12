//
//  NSDate+UG.m
//  LHCloud
//
//  Created by admin on 2019/4/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "NSDate+UG.h"

@implementation NSDate (UG)
/**
 *
 */
-(NSString*)ug_hourTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm"];
    NSString* timeString=[formatter stringFromDate:self];
    return timeString;
}
/**
 *
 */
-(NSString*)ug_groupTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* timeString=[formatter stringFromDate:self];
    return timeString;
}
/**
 *
 */
-(NSString*)ug_mmTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString* timeString=[formatter stringFromDate:self];
    return timeString;
}
/**
 *
 */
-(NSString *)ug_dayTime{
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd号 hh:mm";
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

/**
 *
 */
-(NSString *)defualTime{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日 hh:mm";
    NSString *dateStr = [dateFormatter stringFromDate:self];
    return dateStr;
}

/**
 * 时间计算
 */
-(NSDate*)uf_changeData:(NSInteger)sec{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* timeString=[formatter stringFromDate:self];
    NSDate *newdate = [formatter dateFromString:timeString];
    NSDate *returndate = [newdate initWithTimeInterval:sec sinceDate:newdate];
    return returndate;
}

@end
