//
//  BlockCollectionView.m
//  AFNetworking
//
//  Created by MBA on 2019/5/18.
//

#import "BlockCollectionView.h"
#import "Masonry.h"


@interface BlockCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger indexOffset;

@end

@implementation BlockCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (!layout) {
        layout = self.flowLayout;
    }
    if (self ==[super initWithFrame:frame collectionViewLayout:layout]) {
            self.backgroundColor = UIColor.clearColor;
            self.delegate = self;
            self.dataSource = self;
            self.scrollsToTop = NO;
            self.pagingEnabled = YES;
            self.showsHorizontalScrollIndicator = NO;
            self.showsVerticalScrollIndicator = NO;
            [self registerClass:[BlockCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
-(BlockCollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[BlockCollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.f;
        _flowLayout.minimumInteritemSpacing = 0.f;
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.footerReferenceSize = CGSizeZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


#pragma mark -- UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger secontcount=0;
    
    if (self.ug_numberOfItemsInSection != nil) {
        secontcount = self.ug_numberOfItemsInSection(collectionView,section);
    }
    return secontcount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.ug_cellForItemAtIndexPath) {
        return self.ug_cellForItemAtIndexPath(collectionView,indexPath);
    }else{
        BlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ug_sizeForItemAtIndexPath) {
        return self.ug_sizeForItemAtIndexPath(collectionView, collectionViewLayout,indexPath);
    }else{
        return _flowLayout.itemSize;
    }
}

#pragma mark -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.ug_didSelectItemAtIndexPath) {
        self.ug_didSelectItemAtIndexPath(collectionView,indexPath);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    if (!_isSetcenten) {
//        return;
//    }
//    NSArray *cellarr = [_collectionView indexPathsForVisibleItems];
//    if (cellarr.count>0) {
//        NSIndexPath *indexPath = [cellarr objectAtIndex:(cellarr.count/2)+(cellarr.count%2)-1];
//        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:[self scrollPosition]  animated:YES];
//    }
}

#pragma mark -- UIScrollViewDelegate Delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_isSetcenten) {
        return;
    }
    NSArray *cellarr = [self indexPathsForVisibleItems];
    if (cellarr.count>0) {
        NSIndexPath *indexPath = [cellarr objectAtIndex:(cellarr.count/2)+(cellarr.count%2)-1];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:[self scrollPosition]  animated:YES];
    }
}

//重新定位到中间
- (UICollectionViewScrollPosition)scrollPosition
{
    switch (_flowLayout.scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            return UICollectionViewScrollPositionCenteredVertically;
        default:
            return UICollectionViewScrollPositionCenteredHorizontally;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
@end
