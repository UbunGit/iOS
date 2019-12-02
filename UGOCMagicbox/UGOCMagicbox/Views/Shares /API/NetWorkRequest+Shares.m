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
创建新文件夹
 https://api.github.com/repos/用户名/仓库名/contents/文件路径
*/
-(void)createpath:(NSString*)path sha:(NSString*)sha block:(NREndBlock)block{
    
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/UbunGit/UGFAFAFA/contents/Shares/%@",path];
    
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
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/UbunGit/UGFAFAFA/contents/Shares/%@",path];
    NSDictionary *dic = @{};
    [self get:url param:@{} head:nil endblock:block];
          
}
@end
