//
//  ShareHistoryCell.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/12/4.
//  Copyright © 2019 UG. All rights reserved.
//

#import "ShareHistoryCell.h"
#import "ShareRemarkView.h"
@implementation ShareHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    [self ug_borderColor:COLOREE width:0.5];
    [self ug_radius:4];
    self.titlelab = [UILabel new];
    [self.contentView addSubview:_titlelab];
    _titlelab.font = FONT_SYS12;
     _titlelab.textColor = COLOR23;
    
    self.timelab = [UILabel new];
    [self.contentView addSubview:_timelab];
    _timelab.font = FONT_SYS10;
    _timelab.textColor = COLOR23;
    
    self.handleTimelab = [UILabel new];
    [self.contentView addSubview:_handleTimelab];
    _handleTimelab.font = FONT_SYS10;
    _handleTimelab.textColor = COLOR23;
    
    self.priceinlab = [UILabel new];
    [self.contentView addSubview:_priceinlab];
    _priceinlab.font = FONT_SYS10;
    _priceinlab.textColor = COLOR23;
    
    self.priceoutlab = [UILabel new];
    [self.contentView addSubview:_priceoutlab];
    _priceoutlab.font = FONT_SYS10;
    _priceoutlab.textColor = COLOR23;
    
    self.remarklab = [UILabel new];
    [self.contentView addSubview:_remarklab];
    _remarklab.font = FONT_SYS10;
    _remarklab.textColor = COLOR23;
    _remarklab.numberOfLines = 0;
    [_remarklab ug_borderColor:COLOREE width:0.5];
    
}
-(void)reload:(SharesHistoryData *)data{
    
    _titlelab.text = [NSString stringWithFormat:@"%@(%@)",data.name,data.number];
    _timelab.text = [NSString stringWithFormat:@"测评时间:%zd",data.date];
    NSData *filedata = [[NSFileManager defaultManager] contentsAtPath:data.absfilePath];
    if(filedata){
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:filedata options:NSJSONReadingMutableLeaves error:nil];
        RemarkViewValue *info = [RemarkViewValue modelWithJSON:[dic objectForKey:@"remark"]];
        _priceinlab.text = [NSString stringWithFormat:@"入手：%.2f",info.pricein];
        _priceoutlab.text = [NSString stringWithFormat:@"出手：%.2f",info.priceout];
        _handleTimelab.text = [NSString stringWithFormat:@"操作时间：%f",info.handletime];
        _remarklab.text = info.remark;
        
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
    }];
    
    [_timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_offset(-KPAND_DEF);
    }];
    
    [_handleTimelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titlelab.mas_bottom).mas_offset(KPAND_MIN);
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
    }];
    
    [_priceinlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.handleTimelab.mas_bottom).mas_offset(KPAND_MIN);
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
    }];
    [_priceoutlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.handleTimelab.mas_bottom).mas_offset(KPAND_MIN);
        make.right.mas_equalTo(self.contentView).mas_offset(-KPAND_DEF);
    }];
    [_remarklab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceoutlab.mas_bottom).mas_offset(KPAND_MIN);
        make.left.mas_equalTo(self.contentView).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.contentView).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
}


@end
