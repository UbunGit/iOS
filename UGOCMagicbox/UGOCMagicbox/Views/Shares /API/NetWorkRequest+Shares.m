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
-(void)createpath:(NSString*)path block:(NREndBlock)block{
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/UbunGit/UGFAFAFA/%@",path];
    NSDictionary *dic = @{
        @"message": @"commit from INSOMNIA",
        @"content": @"bXkgbmV3IGZpbGUgY29udGVudHM="
        
    };
    [self put:url param:dic head:nil endblock:block];
}
@end
