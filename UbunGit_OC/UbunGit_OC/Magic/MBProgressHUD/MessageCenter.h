//
//  MessageCenter.h
//  LHCloud
//
//  Created by admin on 2019/3/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageCenter : NSObject

+(void)alert:(NSString*)msg;
+(void)alertimageYype:(NSString*)msg;

+(void)starloading;
+(void)stoploading;

@end

NS_ASSUME_NONNULL_END
