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

#pragma mark -- Init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialization];
    }
    return self;
}

- (void)initialization
{

    _flowLayout = [[BlockCollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.f;
    _flowLayout.minimumInteritemSpacing = 0.f;
    _flowLayout.headerReferenceSize = CGSizeZero;
    _flowLayout.footerReferenceSize = CGSizeZero;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = UIColor.clearColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.scrollsToTop = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[BlockCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
}


- (CGPoint)contentOffset
{
    switch (_flowLayout.scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            return CGPointMake(0.f, MAX(0.f, _collectionView.contentOffset.y - (_flowLayout.itemSize.height + _flowLayout.minimumLineSpacing) * 2));
        default:
            return CGPointMake(MAX(0.f, (_collectionView.contentOffset.x - (_flowLayout.itemSize.width + _flowLayout.minimumLineSpacing) * 2)), 0.f);
    }
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
    if (!_isSetcenten) {
        return;
    }
    NSInteger index = [self currentIndex];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:[self scrollPosition]  animated:NO];
   
}

#pragma mark -- UIScrollViewDelegate Delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_isSetcenten) {
        return;
    }
    NSInteger index = [self currentIndex];
    UICollectionViewScrollPosition position = [self scrollPosition];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:position animated:YES];
}

-(NSInteger)currentIndex
{
    NSInteger index = 0;
    switch (_flowLayout.scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            index = (_collectionView.contentOffset.y + (_flowLayout.itemSize.height + _flowLayout.minimumLineSpacing) / 2) / (_flowLayout.itemSize.height + _flowLayout.minimumLineSpacing);
            break;
        default:
            index = (_collectionView.contentOffset.x + (_flowLayout.itemSize.width + _flowLayout.minimumLineSpacing) / 2) / (_flowLayout.itemSize.width + _flowLayout.minimumLineSpacing);
            break;
    }
    return MAX(0, index);
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
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}
@end
