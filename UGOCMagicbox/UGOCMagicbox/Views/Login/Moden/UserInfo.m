//
//  UserInfo.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/5.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UserInfo.h"
static UserInfo *userinfo = nil;

@implementation UserInfo

+(instancetype)share{
    if (!userinfo) {
        NSDictionary *endinfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"enduserinfo"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"enduserinfo"];
        if (endinfo) {
            UserInfo *temdata = [UserInfo modelWithDictionary:endinfo];
            if (temdata.autoSave) {
                userinfo = temdata;
            }
        }
        if (!userinfo) {
            userinfo = [UserInfo new];
            userinfo.autoSave = YES;
        }

        [[NSNotificationCenter defaultCenter] addObserver:userinfo selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification  object:nil];
    }
    return userinfo;
}

-(BOOL)islogin{
    if (_name.length>0 && _repo.length > 0 && _password.length > 0) {
        return YES;
    }
    return NO;
}


-(void)clear{
    _name = nil;
    _repo = nil;
    _token = nil;
    _password = nil;
}


-(void)applicationDidEnterBackground{
   
    if (self.islogin && _autoSave) {
        NSDictionary *dic = [self modelToJSONObject];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"enduserinfo"];
    }
}
@end
