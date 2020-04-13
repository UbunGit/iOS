//
//  NSDate+UG.h
//  LHCloud
//
//  Created by admin on 2019/4/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (UG)

/**
 * 按指定样式返回，nil返回 yyyy-MM-dd hh:mm
 */
-(NSString*)ug_formatter:(NSString*)formatstr;
/**
 * hh:mm
 */
-(NSString*)ug_hourTime;
/**
 * yyyy-MM-dd
 */
-(NSString*)ug_groupTime;

/**
 * yyyy年MM月dd号 hh:mm
 */
-(NSString *)ug_dayTime;
    
/**
 * yyyy-MM-dd hh:mm
 */
-(NSString*)ug_mmTime;

/**
 * yyyy年MM月dd日 hh:mm
 */
-(NSString *)defualTime;


-(NSDate*)uf_changeData:(NSInteger)sec;


@end

NS_ASSUME_NONNULL_END
