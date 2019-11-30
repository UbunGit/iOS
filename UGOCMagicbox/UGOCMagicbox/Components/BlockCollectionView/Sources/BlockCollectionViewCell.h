//
//  BlockCollectionViewCell.h
//  UbunGit_OC
//
//  Created by MBA on 2019/5/18.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab; //标题

@property (nonatomic, strong) UIView *layview;

@end

NS_ASSUME_NONNULL_END
