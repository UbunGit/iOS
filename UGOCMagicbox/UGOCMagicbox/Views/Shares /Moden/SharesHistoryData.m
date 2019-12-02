//
//  SharesHistoryData.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/27.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesHistoryData.h"

@implementation SharesHistoryData

///** 设置主键 */
//+(NSString *)primaryKey{
//     return @"id";
//}


/**
 获取文件路径 不包括文件名
 */
-(NSString*)abspath{
    NSString *lpath = [NSString stringWithFormat:@"%zd",self.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"%@/%@",self.path,lpath];
    return path;
}

/**
 获取文件路径 包括文件名
 */
-(NSString*)absfilePath{
    NSString *lpath = [NSString stringWithFormat:@"%zd",self.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"%@/%@/%@.json",self.path,lpath,self.number];
    
    return path;
}

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relpath{
    NSString *lpath = [NSString stringWithFormat:@"%zd",self.date];
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.path,lpath];
    return path;
}

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relfilepath{
    NSString *lpath = [NSString stringWithFormat:@"%zd",self.date];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@.json",self.path,lpath,self.number];
    return path;
}

@end
