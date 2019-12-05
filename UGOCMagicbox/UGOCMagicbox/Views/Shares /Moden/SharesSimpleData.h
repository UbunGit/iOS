//
//  SharesSimpleData.h
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/25.
//  Copyright © 2019 UG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 股票简要信息
 */
@interface SharesSimpleData : RLMObject

@property(strong, nonatomic) NSString *name; // 股票名称
@property(strong, nonatomic) NSString* number; // 股票编码

@end

// 关注列表
@interface SharesLikeData : SharesSimpleData


@end


NS_ASSUME_NONNULL_END
