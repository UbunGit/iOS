//
//  UGCycleScrollView.h
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import <UIKit/UIKit.h>
#import "UGCycleScrollViewFlowLayout.h"
#import "UGCycleScrollViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface UGCycleScrollView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UGCycleScrollViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (assign, nonatomic) CGFloat itemSpacing;//间距
@property (assign, nonatomic) CGSize itemSize;//item 大小
@property (nonatomic, assign) IBInspectable CGFloat itemZoomScale; // default 1.f(no scaling), it ranges from 0.f to 1.f



//必须
@property(copy, nonatomic) __kindof UICollectionViewCell *(^ug_cellForItemAtIndexPath)(UICollectionView*collectionView,NSIndexPath* indexPath);

//非必须
@property(copy, nonatomic) NSInteger (^ug_numberOfItemsInSection)(UICollectionView*collectionView,NSInteger section);

@property(copy, nonatomic) void (^ug_didSelectItemAtIndexPath)(UICollectionView*collectionView,NSIndexPath* indexPath);

@end

NS_ASSUME_NONNULL_END
