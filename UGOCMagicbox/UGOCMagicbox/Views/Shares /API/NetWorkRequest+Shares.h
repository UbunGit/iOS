//
//  NetWorkRequest+Shares.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/27.
//  Copyright © 2019 UG. All rights reserved.
//

#import "NetWorkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkRequest (Shares)

/**
创建新文件夹
 https://api.github.com/repos/用户名/仓库名/contents/文件路径
*/
-(void)createpath:(NSString*)path
            lpath:(NSString*)lpath
              sha:(NSString*)sha
          message:(NSString*)message
            block:(NREndBlock)block;

/**
 获取文件信息
  https://api.github.com/repos/UbunGit/UGFAFAFA/contents/Shares/
 */
-(void)getfileInfo:(NSString*)path block:(NREndBlock)block;

/**
 下载历史测评文件
 */
-(void)downHistory:(NSString*)urlstr
          filepath:(NSString *)filepath
          progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
              head:(NSDictionary *)head
          endblock:(NREndBlock)endblock;

@end

NS_ASSUME_NONNULL_END
