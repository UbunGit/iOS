//
//  NetWorkRequest+Shares.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/27.
//  Copyright © 2019 UG. All rights reserved.
//

#import "NetWorkRequest+Shares.h"


@implementation NetWorkRequest (Shares)

/**
创建/更新文件夹
 https://api.github.com/repos/用户名/仓库名/contents/文件路径
*/
-(void)createpath:(NSString*)path sha:(NSString*)sha block:(NREndBlock)block{
    if ([UserInfo share].name<=0) {
        block(nil, [[NSError alloc]initWithDomain:@"用户名不能为空" code:-1 userInfo:nil]);
        return;
    }
    if ([UserInfo share].repo<=0) {
        block(nil, [[NSError alloc]initWithDomain:@"仓库名不能为空" code:-1 userInfo:nil]);
        return;
    }
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/contents/%@",[UserInfo share].name,[UserInfo share].repo, path];
    
    NSString *loctpath = [NSString stringWithFormat:@"%@/%@",PATHDOCUMENT,path];
    NSData *filedata = [[NSFileManager defaultManager] contentsAtPath:loctpath];
    NSString *bath =  [filedata base64EncodedStringWithOptions:0];
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: @{
        @"message": @"UbunGit 备份本地数据库",
        @"content": bath,
    }];
    if(sha){
        [dic setObject:sha forKey:@"sha"];
    }
    [self put:url param:dic head:nil endblock:block];
}

-(void)getfileInfo:(NSString*)path block:(NREndBlock)block{
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/UbunGit/UGFAFAFA/contents/%@",path];
    NSDictionary *dic = @{};
    [self get:url param:dic head:nil endblock:block];
          
}


@end
