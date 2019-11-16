//
//  UGZoneData.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UGZoneSourctData : NSObject

@property(strong, nonatomic) NSString *imageurl;
@property(assign, nonatomic) NSInteger type;

@end


@interface UGZoneData : NSObject

@property(strong, nonatomic) NSString *headimg;
@property(strong, nonatomic) NSString *nick;
@property(strong, nonatomic) NSString *comment;
@property(strong, nonatomic) NSArray<UGZoneSourctData*> *sourctArr;

@end

NS_ASSUME_NONNULL_END
