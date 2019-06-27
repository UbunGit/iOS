//
//  BarcollectionView.m
//  UbunGit_OC
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BarcollectionView.h"
@interface BarcollectionView()

@end
@implementation BarcollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self == [super initWithFrame:frame]){
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 0.f;
    _layout.minimumInteritemSpacing = 0.f;
    _layout.headerReferenceSize = CGSizeZero;
    _layout.footerReferenceSize = CGSizeZero;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    [self addSubview:_collectionView];
    _collectionView.backgroundColor = UIColor.ug_random;
  
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];

}
@end
