//
//  BarcollectionView.h
//  UbunGit_OC
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarcollectionView : UIView

@property(strong, nonatomic) UICollectionViewFlowLayout* layout;
@property(strong, nonatomic) UICollectionView* collectionView;

@end

NS_ASSUME_NONNULL_END
