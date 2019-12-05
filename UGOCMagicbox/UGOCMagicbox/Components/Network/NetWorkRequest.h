//
//  NetWorkRequest.h
//  LifeBox
//
//  Created by Lucky on 2019/8/4.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define BASEURL [NSString stringWithFormat:@"%@:%@",\
[[Global_Variable shared] serviceIP],\
[[Global_Variable shared] defaultPort]\
]

#define SEARCHURL [NSString stringWithFormat:@"%@:%@",[[Global_Variable shared] serviceIP],[[Global_Variable shared] searchPort]]

NS_ASSUME_NONNULL_BEGIN


typedef void(^NREndBlock)(NSDictionary *_Nullable dataDict,  NSError *_Nullable error);


@interface NetWorkRequest : NSObject

@property(strong, nonatomic) AFHTTPSessionManager *afManager;


#pragma mark - 初始化
+ (instancetype)share;

-(void)post:(NSString*)url param:(NSDictionary * _Nullable )param head:(NSDictionary *_Nullable )head endblock:(NREndBlock)endblock;

-(void)get:(NSString*)url param:(NSDictionary *_Nullable )param head:(NSDictionary *_Nullable )head endblock:(NREndBlock)endblock;

-(void)put:(NSString*)url param:(NSDictionary *)param head:(NSDictionary *)head endblock:(NREndBlock)endblock;

/**
 下载文件
 */
-(void)download:(NSString*)urlstr
       filepath:(NSString *)filepath
       progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
           head:(NSDictionary *)head
       endblock:(NREndBlock)endblock;

@end

NS_ASSUME_NONNULL_END
