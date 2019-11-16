//
//  BlockCollectionViewFlowLayout.m
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import "BlockCollectionViewFlowLayout.h"

@implementation BlockCollectionViewFlowLayout{
    CGFloat _sumWidth;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _zoomScale = 1.f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _zoomScale = 1.f;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
//    switch (self.scrollDirection) {
//        case UICollectionViewScrollDirectionVertical: {
//            CGFloat offset = CGRectGetMidY(self.collectionView.bounds);
//            CGFloat distanceForScale = self.itemSize.height + self.minimumLineSpacing;
//            for (UICollectionViewLayoutAttributes *attr in attributes) {
//                CGFloat scale = 0.f;
//                CGFloat distance = ABS(offset - attr.center.y);
//                if (distance >= distanceForScale) {
//                    scale = _zoomScale;
//                } else if (distance == 0.f) {
//                    scale = 1.f;
//                    attr.zIndex = 1;
//                } else {
//                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
//                }
//                attr.transform = CGAffineTransformMakeScale(scale, scale);
//            }
//            break;
//        }
//        default: {
//            CGFloat offset = CGRectGetMidX(self.collectionView.bounds);
//            CGFloat distanceForScale = self.itemSize.width + self.minimumLineSpacing;
//            for (UICollectionViewLayoutAttributes *attr in attributes) {
//                CGFloat scale = 0.f;
//                CGFloat distance = ABS(offset - attr.center.x);
//                if (distance >= distanceForScale) {
//                    scale = _zoomScale;
//                } else if (distance == 0.f) {
//                    scale = 1.f;
//                    attr.zIndex = 1;
//                } else {
//                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
//                }
//                attr.transform = CGAffineTransformMakeScale(scale, scale);
//            }
//            break;
//        }
//    }
    
    // cell 设置居左 局右 局中
    NSMutableArray * layoutAttributesTemp = [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index < attributes.count ; index++) {
        
        UICollectionViewLayoutAttributes *currentAttr = attributes[index]; // 当前cell的位置信息
        UICollectionViewLayoutAttributes *previousAttr = index == 0 ? nil : attributes[index-1]; // 上一个cell 的位置信
        UICollectionViewLayoutAttributes *nextAttr = index + 1 == attributes.count ?
        nil : attributes[index+1];//下一个cell 位置信息
        
        //加入临时数组
        [layoutAttributesTemp addObject:currentAttr];
        _sumWidth += currentAttr.frame.size.width;
        
        CGFloat previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr.frame);
        CGFloat currentY = CGRectGetMaxY(currentAttr.frame);
        CGFloat nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr.frame);
        //如果当前cell是单独一行
        if (currentY != previousY && currentY != nextY){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            }else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                [layoutAttributesTemp removeAllObjects];
                _sumWidth = 0.0;
            }else{
                [self setCellFrameWith:layoutAttributesTemp];
            }
        }
        //如果下一个不cell在本行，则开始调整Frame位置
        else if( currentY != nextY) {
            [self setCellFrameWith:layoutAttributesTemp];
        }
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}

-(void)setCellFrameWith:(NSMutableArray*)layoutAttributes{
    CGFloat nowWidth = 0.0;
    switch (_cellType) {
        case AlignWithLeft:
            nowWidth = self.sectionInset.left;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.minimumLineSpacing;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
        case AlignWithCenter:
            nowWidth = (self.collectionView.frame.size.width - _sumWidth - (layoutAttributes.count * self.minimumLineSpacing)) / 2;
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth;
                attributes.frame = nowFrame;
                nowWidth += nowFrame.size.width + self.minimumLineSpacing;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
            
        case AlignWithRight:
            nowWidth = self.collectionView.frame.size.width - self.sectionInset.right;
            for (NSInteger index = layoutAttributes.count - 1 ; index >= 0 ; index-- ) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[index];
                CGRect nowFrame = attributes.frame;
                nowFrame.origin.x = nowWidth - nowFrame.size.width;
                attributes.frame = nowFrame;
                nowWidth = nowWidth - nowFrame.size.width - self.minimumLineSpacing;
            }
            _sumWidth = 0.0;
            [layoutAttributes removeAllObjects];
            break;
            
    }
}




@end
