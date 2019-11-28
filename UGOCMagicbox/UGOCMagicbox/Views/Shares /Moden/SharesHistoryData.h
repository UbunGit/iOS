//
//  SharesHistoryData.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/27.
//  Copyright © 2019 UG. All rights reserved.
//

#import <Realm/Realm.h>
#import "SharesSimpleData.h"
NS_ASSUME_NONNULL_BEGIN

@interface SharesHistoryData : SharesSimpleData

/** super
 @property(strong, nonatomic) NSString *name; // 股票名称
 @property(strong, nonatomic) NSString* number; //股票编码
 @property(assign, nonatomic) NSInteger date; //股票时间
 */

@property(strong, nonatomic) NSString *path; //本地存储相对路径

@property(assign, nonatomic) BOOL isCommit; //是否已提交至服务器

@property(assign, nonatomic) NSTimeInterval edittime; //最后修改时间



/**
 获取文件路径 不包括文件名
 */
-(NSString*)abspath;

/**
 获取文件路径 包括文件名
 */
-(NSString*)absfilePath;

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relpath;

/**
 获取相对文件路径 不包括文件名
 */
-(NSString*)relfilepath;


@end

NS_ASSUME_NONNULL_END
