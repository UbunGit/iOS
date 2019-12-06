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
    
   /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [_afManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filepath];
                
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        endblock(nil,error);
    }];
     [downloadTask resume];
}

-(NSString*)getclientAgent{
    NSDictionary *dic = @{@"verstion":@"v1.0.1",@"platform":@"iOS"};
    return @"{verstion:\"v1.0.1\",platform:\"iOS\"}";
    
}

@end
