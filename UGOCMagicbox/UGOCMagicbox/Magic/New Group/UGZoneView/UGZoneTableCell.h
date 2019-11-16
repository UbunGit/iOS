//
//  UGZoneTableCell.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGZoneData.h"
#import "BlockCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UGZoneTableCell : UITableViewCell

@property(strong, nonatomic) UGZoneData *data;


@property(strong, nonatomic)UIImageView *headImageview;//头像


@property(strong, nonatomic)UILabel *nickLab;//昵称


@property(strong, nonatomic)UILabel *commentLab;//内容

@property(strong, nonatomic)BlockCollectionView *collectionView;//图片/视频

-(void)reload:(UGZoneData*)data;

@end

NS_ASSUME_NONNULL_END
