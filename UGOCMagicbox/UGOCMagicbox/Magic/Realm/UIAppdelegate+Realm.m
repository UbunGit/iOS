//
//  UIAppdelegate+Realm.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/30.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UIAppdelegate+Realm.h"

#import "NetWorkRequest+Shares.h"

@implementation UIApplication (Realm)

-(void)configRealm:(NSURL*)path{
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // 设置新的架构版本。必须大于之前所使用的版本
    // （如果之前从未设置过架构版本，那么当前的架构版本为 0）
    if (path) {
        config.fileURL = path;
    }
    config.schemaVersion = 4;
    // 设置模块，如果 Realm 的架构版本低于上面所定义的版本，
    // 那么这段代码就会自动调用
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // 我们目前还未执行过迁移，因此 oldSchemaVersion == 0
        if (oldSchemaVersion < config.schemaVersion) {
            // enumerateObjects:block: 方法将会遍历
            // 所有存储在 Realm 文件当中的 `Person` 对象
//            [migration enumerateObjects:Person.className
//                                  block:^(RLMObject *oldObject, RLMObject *newObject) {

            // 将两个 name 合并到 fullName 当中
//            newObject[@"fullName"] = [NSString stringWithFormat:@"%@ %@",
//                                          oldObject[@"firstName"],
//                                          oldObject[@"lastName"]];
//            }];
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    // 现在我们已经通知了 Realm 如何处理架构变化，
    // 打开文件将会自动执行迁移
    [RLMRealm defaultRealm];
}

-(NSString*)getsha{
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultRealm"];
    return  [dic objectForKey:@"sha"];
}

-(NSString*)getDownurl{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultRealm"];
    return  [dic objectForKey:@"download_url"];
}
/**
 获取数据库文件 sha
 */
-(void)updateRealInfo:(void(^)(NSError*error,NSDictionary*result))endblock{
    [[NetWorkRequest share] getfileInfo:@"Shares/default.realm" block:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
        if (error) {
          
            endblock(error,nil);
        }else{
            [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:@"defaultRealm"];
            endblock(nil,dataDict);
        }
    }];
    
}
@end
