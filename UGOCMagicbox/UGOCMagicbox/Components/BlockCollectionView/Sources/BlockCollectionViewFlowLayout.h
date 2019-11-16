//
//  BlockCollectionViewFlowLayout.h
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,UGAlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface BlockCollectionViewFlowLayout : UICollectionViewFlowLayout

//cell对齐方式 设置居左 局右 局中
@property (nonatomic,assign)UGAlignType cellType;

@property (nonatomic, assign) CGFloat zoomScale; // default 1.f, it ranges from 0.f to 1.f

@end

NS_ASSUME_NONNULL_END
