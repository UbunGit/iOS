//
//  SharesHistoryData.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/27.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesHistoryData.h"

@implementation SharesHistoryData
-(NSString *)key{
    if (!_key) {
        _key = [self makeKey];
    }
    return _key;
}
///** 设置主键 */
+(NSString *)primaryKey{
     return @"key";
}
-(NSString*)makeKey{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%@", [date ug_formatter:@"yyyyMMddhhmmss"]];
}
/**
 获取文件路径 不包括文件名
 */
-(NSString*)abspath{
    NSString *lpath = [NSString stringWithFormat:@"shares/history/%zd",self.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"/%@",lpath];
    return path;
}

/**
 获取文件路径 包括文件名
 */
-(NSString*)absfilePath{
    NSString *lpath = [NSString stringWithFormat:@"shares/history/%zd",self.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"/%@/%@.json",lpath,self.number];
    
    return path;
}

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relpath{
    NSString *lpath = [NSString stringWithFormat:@"shares/history/%zd",self.date];
    return lpath;
}

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relfilepath{
    NSString *lpath = [NSString stringWithFormat:@"shares/history/%zd/%@.json",self.date,self.number];
    return lpath;
}

@end
