//
//  UGZoneTableCell.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGZoneTableCell.h"




@implementation UGZoneTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.headImageview = [UIImageView new];
    [self.contentView addSubview:_headImageview];
    [_headImageview ug_radius:KAutoAcale(21)];
    
    self.nickLab = [UILabel new];
    [self.contentView addSubview:_nickLab];
    _nickLab.font = FONT_SYS16;
    _nickLab.textColor = [UIColor ug_hexString:@"#576B95"];
    
    self.commentLab = [UILabel new];
    [self.contentView addSubview:_commentLab];
    _commentLab.numberOfLines = 2;
    _commentLab.font = FONT_SYS14;
    self.collectionView = [BlockCollectionView new];
    [self.contentView addSubview:_collectionView];
    
    UG_WEAKSELF
    _collectionView.flowLayout.minimumLineSpacing = 8.f;
    _collectionView.flowLayout.minimumInteritemSpacing = 8.f;
    _collectionView.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.ug_numberOfItemsInSection = ^NSInteger(UICollectionView * _Nonnull collectionView, NSInteger section) {
        return weakSelf.data.sourctArr.count;
    };
    _collectionView.ug_sizeForItemAtIndexPath = ^CGSize(UICollectionView * _Nonnull collectionView, UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
        UGZoneSourctData *tdata = [weakSelf.data.sourctArr objectAtIndex:indexPath.row];
       
        if (tdata.type == 0 ) {
            return CGSizeMake(80, 80);
        }else{
            return CGSizeMake(100, 100);
        }
    };
    _collectionView.ug_cellForItemAtIndexPath = ^__kindof UICollectionViewCell * _Nonnull(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
        BlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UGZoneSourctData *tdata = [weakSelf.data.sourctArr objectAtIndex:indexPath.row];
        [cell.imageView sd_setImageWithURL:UGURL(tdata.imageurl)];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        return cell;
    };

}

-(void)reload:(UGZoneData*)data{
    _data = data;
    [_headImageview sd_setImageWithURL:UGURL(data.headimg)];
    _nickLab.text =[NSString stringWithFormat:@"%@(%zdf)",data.nick,data.sourctArr.count] ;
    _commentLab.text = data.comment;
    [_collectionView reloadData];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    CGFloat height = _collectionView.flowLayout.collectionViewContentSize.height;
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.commentLab.mas_bottom).mas_offset(8);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-8);
        make.left.right.mas_equalTo(self.commentLab);
        make.height.mas_equalTo(height);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_headImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(8);
        make.left.mas_equalTo(self.contentView).mas_offset(8);
        make.size.mas_equalTo(CGSizeMake(KAutoAcale(42), KAutoAcale(42)));
    }];
    
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageview.mas_top);
        make.left.mas_equalTo(self.headImageview.mas_right).mas_offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-8);
    }];
    [_commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickLab.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.headImageview.mas_right).mas_offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-8);
    }];
  
}

@end
