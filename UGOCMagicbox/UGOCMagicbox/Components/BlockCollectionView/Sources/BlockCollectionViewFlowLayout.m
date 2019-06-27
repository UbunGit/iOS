//
//  BlockCollectionViewFlowLayout.m
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import "BlockCollectionViewFlowLayout.h"

@implementation BlockCollectionViewFlowLayout

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
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            CGFloat offset = CGRectGetMidY(self.collectionView.bounds);
            CGFloat distanceForScale = self.itemSize.height + self.minimumLineSpacing;
            for (UICollectionViewLayoutAttributes *attr in attributes) {
                CGFloat scale = 0.f;
                CGFloat distance = ABS(offset - attr.center.y);
                if (distance >= distanceForScale) {
                    scale = _zoomScale;
                } else if (distance == 0.f) {
                    scale = 1.f;
                    attr.zIndex = 1;
                } else {
                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
                }
                attr.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
        default: {
            CGFloat offset = CGRectGetMidX(self.collectionView.bounds);
            CGFloat distanceForScale = self.itemSize.width + self.minimumLineSpacing;
            for (UICollectionViewLayoutAttributes *attr in attributes) {
                CGFloat scale = 0.f;
                CGFloat distance = ABS(offset - attr.center.x);
                if (distance >= distanceForScale) {
                    scale = _zoomScale;
                } else if (distance == 0.f) {
                    scale = 1.f;
                    attr.zIndex = 1;
                } else {
                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
                }
                attr.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return true;
}


@end
