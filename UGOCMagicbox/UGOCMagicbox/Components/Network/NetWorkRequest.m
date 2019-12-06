//
//  NetWorkRequest.m
//  LifeBox
//
//  Created by Lucky on 2019/8/4.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "NetWorkRequest.h"


@implementation NetWorkRequest

/**
 * 静态变量
 */
static NetWorkRequest *netWorkRequest = nil;


#pragma mark - 初始化
+ (instancetype)share {
  
    if (!netWorkRequest) {
        netWorkRequest = [NetWorkRequest new];
        [netWorkRequest install];
    }
    return netWorkRequest;
}

-(void)install{
    self.afManager = [AFHTTPSessionManager manager];
    _afManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _afManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript",@"text/html",@"text/plain",@"image/jpeg",
                                                           @"image/png", @"application/octet-stream",  nil];
    [_afManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置网络延时
    _afManager.requestSerializer.timeoutInterval = 15;
}

-(void)post:(NSString*)url param:(NSDictionary *)param head:(NSDictionary *)head endblock:(NREndBlock)endblock{
    
    if ([UserInfo share].islogin) {
        [[NetWorkRequest share].afManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[UserInfo share].name password:[UserInfo share].password];
    }else{
        NSError *error = [NSError errorWithDomain:@"用户未登陆" code:-1 userInfo:nil];
        if (endblock) {
            endblock(nil,error);
        }
    }
 
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [_afManager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    
    [_afManager.requestSerializer setValue:[self getclientAgent] forHTTPHeaderField:@"client_Agent"];
    if (head) {
        for (NSString *key in head) {
            [_afManager.requestSerializer setValue:head[key] forHTTPHeaderField:key];
        }
    }
    
    //网络判断

    //开始请求
    [_afManager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* response = (NSHTTPURLResponse* )task.response;
        NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
        NSString *setCookie = allHeaderFieldsDic[@"Set-Cookie"];
        if (setCookie != nil) {
            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:cookie forKey:@"Set-Cookie"];
        }
        if (responseObject) {
            /*
             * 解析请求返回码
             */
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                DDLogVerbose(@"{POST}url:%@ \nheader:%@ \nparame:%@ \nresult:%@", url, _afManager.requestSerializer, param, responseObject);
                NSDictionary *dic = responseObject[@"data"];
                if (endblock) {
                    endblock(dic,nil);
                }
            }else{
                
                NSError *error = [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"code"] integerValue] userInfo:responseObject];
                DDLogWarn(@"❗️{POST}url:%@ \nheader:%@ \nparame:%@ \nerror:%@", url, _afManager.requestSerializer, param, responseObject);
                
                if (endblock) {
                    endblock(nil,error);
                }
            }

        }else{
          
            DDLogWarn(@"❗️{POST}url:%@ \nheader:%@ \nparame:%@ \nerror:%@", url, _afManager.requestSerializer, param, @"接口未返回数据");
            if (endblock) {
                endblock(nil,[NSError errorWithDomain:@"接口未返回数据" code:-1 userInfo:nil]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        DDLogWarn(@"❗️{POST}url:%@ \nheader:%@ \nparame:%@ \nerror:%@", url, _afManager.requestSerializer, param, error);
        if (endblock) {
            endblock(nil,error);
        }
    }];
    
}

-(void)get:(NSString*)url param:(NSDictionary *)param head:(NSDictionary *)head endblock:(NREndBlock)endblock{
    
    [_afManager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSHTTPURLResponse* response = (NSHTTPURLResponse* )task.response;
//        NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
//        NSString *setCookie = allHeaderFieldsDic[@"Set-Cookie"];
//        if (setCookie != nil) {
//            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
//            [[NSUserDefaults standardUserDefaults]setObject:cookie forKey:@"Set-Cookie"];
//        }
        /*
         * 解析请求返回码
         */
     
        DDLogVerbose(@"{GET}url:%@ \nparame:%@ \nresult:%@", url, param, responseObject);
      
        if (endblock) {
            endblock(responseObject,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogWarn(@"❗️{GET}url:%@ \nparame:%@ \nerror:%@", url, param, error);
        if (endblock) {
            endblock(nil,[NSError errorWithDomain:@"加载失败" code:error.code userInfo:nil]);
        }
    }];
}

-(void)put:(NSString*)url param:(NSDictionary *)param head:(NSDictionary *)head endblock:(NREndBlock)endblock{
    if ([UserInfo share].islogin) {
        [[NetWorkRequest share].afManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[UserInfo share].name password:[UserInfo share].password];
    }else{
        NSError *error = [NSError errorWithDomain:@"用户未登陆" code:-1 userInfo:nil];
        if (endblock) {
            endblock(nil,error);
        }
    }
    [_afManager PUT:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLogVerbose(@"{PUT}url:%@ \nparame:%@ \nresult:%@", url, param, responseObject);
        
        if (endblock) {
            endblock(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogWarn(@"❗️{PUT}url:%@ \nparame:%@ \nerror:%@", url, param, error);
        if (endblock) {
            endblock(nil,[NSError errorWithDomain:@"加载失败" code:error.code userInfo:nil]);
        }
    }];
    
}
-(void)download:(NSString*)urlstr filepath:(NSString *)filepath progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock head:(NSDictionary *)head endblock:(NREndBlock)endblock{
    if ([UserInfo share].islogin) {
        [[NetWorkRequest share].afManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[UserInfo share].name password:[UserInfo share].password];
    }else{
        NSError *error = [NSError errorWithDomain:@"用户未登陆" code:-1 userInfo:nil];
        if (endblock) {
            endblock(nil,error);
        }
    }

    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *tempath = NSTemporaryDirectory();
    NSString *temfile = [tempath stringByAppendingPathComponent:url.lastPathComponent];
    DDLogVerbose(@"开始下载：%@",urlstr);
    DDLogVerbose(@"零时文件：%@",temfile);
    DDLogVerbose(@"保存地址：%@",filepath);
   /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [_afManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:temfile];
                
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            if (filepath) {
                BOOL isSuccess = [NetWorkRequest copyItemAtPath:temfile toPath:filepath overwrite:YES error:&error];
                if (isSuccess) {
                    endblock(@{@"path":filepath},error);
                }else{
                    endblock(nil,error);
                }
            }else{
                endblock(@{@"path":temfile},error);
            }
        }else{
            endblock(nil,error);
        }
    }];
     [downloadTask resume];
}

-(NSString*)getclientAgent{
    return @"{verstion:\"v1.0.1\",platform:\"iOS\"}";
    
}

/*参数1、被复制文件路径
 *参数2、要复制到的目标文件路径
 *参数3、当要复制到的文件路径文件存在，会复制失败，这里传入是否覆盖
 *参数4、错误信息
 */
+ (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径" format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [toPath stringByDeletingLastPathComponent];
    if (![self isExistsAtPath:toDirPath]) {
        NSFileManager *manager = [NSFileManager defaultManager];

        BOOL isSuccess = [manager createDirectoryAtPath:toDirPath withIntermediateDirectories:YES attributes:nil error:error];
        // 创建复制路径
        if (!isSuccess) {
            return NO;
        }
    }
    // 如果覆盖，那么先删掉原文件
    if (overwrite) {
        if ([self isExistsAtPath:toPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:error];
        }
    }
    // 复制文件，如果不覆盖且文件已存在则会复制失败
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:error];
    
    return isSuccess;
}
 
#pragma mark - 判断文件(夹)是否存在
+ (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
