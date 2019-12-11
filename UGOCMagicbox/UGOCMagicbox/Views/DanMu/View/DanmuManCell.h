//
//  DanmuManCell.h
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import <OCBarrage/OCBarrage.h>

#import "DanmuManDescriptor.h"
NS_ASSUME_NONNULL_BEGIN

@interface DanmuManCell : OCBarrageTextCell{
    CGRect _contentRect;
}

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) DanmuManDescriptor *danmuManDescriptor;
@end

NS_ASSUME_NONNULL_END
