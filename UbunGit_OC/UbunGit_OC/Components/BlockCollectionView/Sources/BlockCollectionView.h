//
//  BlockCollectionView.h
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import <UIKit/UIKit.h>
#import "BlockCollectionViewFlowLayout.h"
#import "BlockCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface BlockCollectionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BlockCollectionViewFlowLayout *flowLayout;

@property (assign, nonatomic) BOOL isSetcenten;//是否设置选中的内容正中间

@property(copy, nonatomic) NSInteger (^ug_numberOfItemsInSection)(UICollectionView*collectionView, NSInteger section);

@property(copy, nonatomic) __kindof UICollectionViewCell *(^ug_cellForItemAtIndexPath)(UICollectionView*collectionView, NSIndexPath* indexPath);

@property(copy, nonatomic) void (^ug_didSelectItemAtIndexPath)(UICollectionView*collectionView, NSIndexPath* indexPath);
@property(copy, nonatomic) CGSize (^ug_sizeForItemAtIndexPath)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSIndexPath* indexPath);

@end

NS_ASSUME_NONNULL_END
