//
//  SharesCollectionCell.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesCollectionCell.h"
#import "ShareOptionCell.h"

@implementation ToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)setKey:(NSString *)key{
    _key = key;
    [self updateDatalist];
}
-(void)updateDatalist{
    if (_key) {
        self.datalist = [SharesTargetOption objectsWhere:[NSString stringWithFormat:@"targetKey='%@'",_key]];
    }
    [_blockTableView reloadData];
    
}
-(void)configUI{
    [self ug_radius:22];
    self.blockTableView = [BlockTableView new];
    [self addSubview:_blockTableView];
    
    UG_WEAKSELF
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return weakSelf.datalist.count;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
        ShareOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareOptionCell"];
        if (cell == nil) {
            cell = [[ShareOptionCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: @"ShareOptionCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SharesTargetOption *data = [weakSelf.datalist objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",data.title,data.value];
        if([data isEqual:weakSelf.selectData]){
            [cell.selectImage setBackgroundColor:UIColor.redColor];
            [cell.textLabel setTextColor:COLOR00_04];
        }else{
            [cell.selectImage setBackgroundColor:UIColor.clearColor];
            [cell.textLabel setTextColor:COLOR23];
        }
        
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 44;
    };
  
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
@end

@implementation SharesCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.toolView = [ToolView new];
    [self.contentView addSubview:_toolView];
    
    self.titleLab = [UILabel new];
    [self.contentView addSubview:_titleLab];
    _titleLab.font = FONT_SYS20;
    _titleLab.textColor = COLOR23;
    _titleLab.numberOfLines = 0;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    
    self.numberLab= [UILabel new];
    [self.contentView addSubview:_numberLab];
    _numberLab.font = FONT_SYS12;
    _numberLab.textColor = COLOR23;
    _numberLab.textAlignment = NSTextAlignmentCenter;
    
    
    self.valueLab = [UILabel new];
    [self.contentView addSubview:_valueLab];
    _valueLab.font = [UIFont systemFontOfSize:26];
    _valueLab.textAlignment = NSTextAlignmentCenter;
    _valueLab.textColor = UIColor.whiteColor;
    _valueLab.backgroundColor = COLORDANGER;
    _valueLab.text = @"未评分";
    [_valueLab ug_radius:60];
 
}

-(void)reloadData:(SharesTargetData*)data{
    _titleLab.text = [NSString stringWithFormat:@"%@",data.title];
    _toolView.key = data.key;
}

-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self.contentView).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        
    }];
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLab.mas_top).mas_equalTo(-100);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        
    }];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_equalTo(100);
        make.left.mas_equalTo(self.contentView).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self).mas_equalTo(-KPAND_DEF);
    }];
    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-KPAND_DEF);
        
    }];
}
@end
