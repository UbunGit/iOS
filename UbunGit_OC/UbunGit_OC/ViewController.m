//
//  ViewController.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(clickDoit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:imageview];
    imageview.backgroundColor = [UIColor blueColor];
    SDWebImageDownloader *sdmanager = [SDWebImageManager sharedManager].imageDownloader;
    [sdmanager setValue:@"true"forHTTPHeaderField:@"OCS-APIREQUEST"];
    [sdmanager setValue:@"Basic YWRtaW46SlJoMlViTUZoUjNMYThjb1hUa3Voa1JHbGdPMDdPRzFxV2FMaWlwR2tra0UyNm9iZ1NEZGRxdjRlc1dOY0w4dVNaZzhRTnFj" forHTTPHeaderField:@"Authorization"];
    
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"http://192.168.50.254/server/index.php/core/preview.png?file=001/001-1/001-1-1/001.jpg&x=400&y=400&a=1&mode=cover"]];
    
}
- (IBAction)clickDoit:(id)sender {
    NSURLSessionDataTask *tem = [self dataTaskWithHTTPMethod:@"PROPFIND" URLString:@"http://192.168.50.254/server/remote.php/dav/files/admin/" parameters:nil uploadProgress:^(NSProgress *uploadProgress) {
        NSLog(@"=");
    } downloadProgress:^(NSProgress *downloadProgress) {
        NSLog(@"=");
    } success:^(NSURLSessionDataTask * task, id ff) {
        NSLog(@"=");
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"=");
    }];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    AFHTTPSessionManager *manage = [self sharedSessionManager];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer new] requestWithMethod:method URLString:URLString parameters:nil error:nil];
    [request setCachePolicy: NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval: 15];
    
    [request setValue:@"0" forHTTPHeaderField: @"Depth"];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"true" forHTTPHeaderField:@"OCS-APIREQUEST"];
    [request setValue:@"Basic YWRtaW46YWRtaW4=" forHTTPHeaderField:@"Authorization"];

//    [manage.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"admin"];
    [request setHTTPBody:[@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><D:propfind xmlns:D=\"DAV:\" xmlns:oc=\"http://owncloud.org/ns\" xmlns:nc=\"http://nextcloud.org/ns\"><D:prop><D:resourcetype/><D:getlastmodified/><size xmlns=\"http://owncloud.org/ns\"/><favorite xmlns=\"http://owncloud.org/ns\"/><id xmlns=\"http://owncloud.org/ns\"/><D:getcontentlength/><D:getetag/><oc:fileid/><permissions xmlns=\"http://owncloud.org/ns\"/><D:getcontenttype/><nc:is-encrypted/><nc:has-preview/></D:prop></D:propfind>" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"header:%@",request.allHTTPHeaderFields);
//    NSMutableURLRequest *request = [manage.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:manage.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(manage.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [manage dataTaskWithRequest:request
                            uploadProgress:uploadProgress
                          downloadProgress:downloadProgress
                         completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                             NSDictionary *dic =[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                             if (error) {
                                 if (failure) {
                                     failure(dataTask, error);
                                 }
                             } else {
                                 if (success) {
                                     success(dataTask, responseObject);
                                 }
                             }
                         }];
    [dataTask resume];
    return dataTask;
}

static AFHTTPSessionManager *_manager = nil;
- (AFHTTPSessionManager *)sharedSessionManager {
    

    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        _manager = [AFHTTPSessionManager manager];
        
        /**
         *  AFHTTPRequestSerializer：是普通的 HTTP 的编码格式的，也就是 mid=10&method=userInfo&dateInt=20160818 这种格式的。
         *
         *  AFJSONRequestSerializer：是 JSON 编码格式的，也就是 {"mid":"11","method":"userInfo","dateInt":"20160818"} 这种格式的。
         *
         *  AFPropertyListRequestSerializer：是plist编码格式的。
         */
        
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        //        [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [_manager.requestSerializer setValue:@"true"forHTTPHeaderField:@"OCS-APIREQUEST"];
//        [_manager.requestSerializer setValue:@"Basic YWRtaW46YWRtaW4=" forHTTPHeaderField:@"Authorization"];
      
        _manager.requestSerializer.timeoutInterval =  30;
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", nil];
        
        //关闭缓存，避免干扰调试
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
//        //设置安全策略
//        if(weakSelf.requestWay !=  requestWayHttpAndCAHttps) {[_manager setSecurityPolicy:[weakSelf securityPolicy]];}
    });
    
    //开启状态栏动画
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    return _manager;
}
@end
