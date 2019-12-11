//
//  DamuSendView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DamuSendView.h"
@implementation DamuHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{

    
    self.headImageView = [UIImageView new];
    [self addSubview:_headImageView];
    [_headImageView ug_radius:KAutoAcale(21)];
    [_headImageView sd_setImageWithURL:UGURL(@"https://github.com/UbunGit/TestRepo/raw/master/image/animal/0.jpg") placeholderImage:UGIMAGE(@"img_1")];
    
    self.remarkImageView = [UIImageView new];
    [self addSubview:_remarkImageView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_remarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(KAutoAcale(42));
    }];
}

@end

@implementation DamuHeadCell
- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self == [super initWithFrame:frame]) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    self.headView = [DamuHeadView new];
    [self.contentView addSubview:_headView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
@end

@implementation DamuInputView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    self.textField = [UGTextField new];
    [self addSubview:_textField];
    [_textField ug_radius:KAutoAcale(17)];
    [_textField ug_borderColor:[UIColor ug_hexString:@"#FF5825"] width:1];
    _textField.offset = KAutoAcale(20.5);
    _textField.font = FONT_SYS14;
    self.sendBtn = [UIButton new];
    [self addSubview:_sendBtn];
    [_sendBtn setImage:UGIMAGE(@"img_1") forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.height.mas_equalTo(KAutoAcale(34));
        make.width.mas_equalTo(KAutoAcale(280));
    }];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.textField.mas_right);
    }];
    
}

@end

@implementation DamuSendView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    self.contentView = [UIView new];
    [self addSubview:_contentView];
    _contentView.backgroundColor = UIColor.whiteColor;
    
    self.headView = [DamuHeadView new];
    [self addSubview:_headView];
    _headView.backgroundColor = UIColor.yellowColor;
    

    
    self.inputView = [DamuInputView new];
    [_contentView addSubview:_inputView];
    _inputView.textField.placeholder = @"快来写一句祝福语吧~";
    
    self.titleLab = [UILabel new];
    [_contentView addSubview:_titleLab];
    _titleLab.text = @"选择头像贴纸";
    
    _titleLab.font = FONT_SYS14;
    _titleLab.textColor = COLOR23;
    
    self.collectionView = [BlockCollectionView new];
    [_contentView addSubview:_collectionView];
    
    _collectionView.pagingEnabled = NO;
    _collectionView.flowLayout.minimumLineSpacing = KAutoAcale(10);
    _collectionView.flowLayout.minimumInteritemSpacing = KAutoAcale(10);
    _collectionView.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.flowLayout.cellType = AlignWithLeft;
    [_collectionView registerClass:[DamuHeadCell class] forCellWithReuseIdentifier:@"DamuHeadCell"];
    _collectionView.ug_numberOfItemsInSection = ^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
        return 300;
    };
    _collectionView.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
        
        return CGSizeMake(KAutoAcale(60),KAutoAcale(60));
        
    };
    _collectionView.ug_cellForItemAtIndexPath = ^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        DamuHeadCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DamuHeadCell" forIndexPath:indexPath];
        cell.backgroundColor = UIColor.ug_random;
        [cell ug_radius:KAutoAcale(4)];
        [cell ug_borderColor:COLOREE width:1];
        return cell;
    };
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_contentView.mas_top).mas_offset(KAutoAcale(24));
        make.left.mas_equalTo(_contentView).mas_offset(KPAND_DEF);
        make.size.mas_equalTo(CGSizeMake(KAutoAcale(74), KAutoAcale(74)));
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KAutoAcale(34.5));
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(KAutoAcale(34.5));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputView.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.contentView);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(KPAND_DEF);
        make.height.mas_equalTo(KAutoAcale(130));
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_offset(-KPAND_DEF);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-KPAND_DEF);
    }];
}

@end
