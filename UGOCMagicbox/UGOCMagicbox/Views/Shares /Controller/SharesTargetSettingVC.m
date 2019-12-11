//
//  SharesTargetSettingVC.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesTargetSettingVC.h"

#import "UGRemarkView.h"
#import "TargetOptionHeadView.h"
#import "TargetOptionAddView.h"
#import "PersentViewController.h"

@interface SharesTargetSettingVC ()

@property(strong, nonatomic) UIScrollView *scrollerView;
@property(strong, nonatomic) UGRemarkView *titleTF;
@property(strong, nonatomic) UGRemarkView *remarkTV;
@property(strong, nonatomic) UGRemarkView *contentTV;
@property(strong, nonatomic) TargetOptionHeadView* targetOptionHeadView;
@property(strong, nonatomic) BlockTableView *blockTableView;
@property(strong, nonatomic) PersentViewController *persent;
@property(strong, nonatomic) TargetOptionAddView *targetOptionAddView;
@property(strong, nonatomic) RLMResults<SharesTargetOption*> *options;

@property(strong, nonatomic) UIButton *saveBtn;

@end

@implementation SharesTargetSettingVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configUI];
    [self initData];
}
-(void)initData{
    if (!_data) {
        self.data = [SharesTargetData new];
        _data.key = [_data makeKey];
    }
    _titleTF.text = _data.title;
    _remarkTV.text = _data.remark;
    _contentTV.text = _data.cotent;
    
    [self reloadOptionData];
}

-(void)reloadOptionData{
    
    self.options = [SharesTargetOption objectsWhere:[NSString stringWithFormat:@"targetKey='%@'",_data.key]];
    [_blockTableView reloadData];
}
-(void)configUI{
    self.title = @"编辑属性";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.scrollerView = [UIScrollView new];
    [self.view addSubview:_scrollerView];
    
    self.titleTF = [UGRemarkView new];
    [_scrollerView addSubview:_titleTF];
    _titleTF.titlaLabel.text = @"指标名称";
    
    self.remarkTV = [UGRemarkView new];
    [_scrollerView addSubview:_remarkTV];
    _remarkTV.titlaLabel.text = @"指标描述";
    
    self.contentTV = [UGRemarkView new];
    [_scrollerView addSubview:_contentTV];
    _contentTV.titlaLabel.text = @"指标规则";
    
    UG_WEAKSELF
    self.targetOptionHeadView = [TargetOptionHeadView new];
    [self.view addSubview:_targetOptionHeadView];
    [_targetOptionHeadView.addBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        self.persent = [PersentViewController new];
        self.targetOptionAddView.editData = nil;
        weakSelf.persent.cotentView = self.targetOptionAddView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    }];
    
    _blockTableView = [BlockTableView new];
    [_scrollerView addSubview:_blockTableView];
    [_blockTableView ug_radius:5];
    _blockTableView.scrollEnabled = NO;
    
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return weakSelf.options.count;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: @"cellid"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SharesTargetOption *temdata = [weakSelf.options objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",temdata.title,temdata.value];
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 44;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        SharesTargetOption *temdata = [weakSelf.options objectAtIndex:indexPath.row];
        weakSelf.persent = [PersentViewController new];
        weakSelf.targetOptionAddView.editData = temdata;
        weakSelf.persent.cotentView = weakSelf.targetOptionAddView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    };
    _blockTableView.commitEditingStyle = ^(UITableView * _Nonnull tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath * _Nonnull indexPath) {
        SharesTargetOption *temdata = [weakSelf.options objectAtIndex:indexPath.row];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            
            [realm deleteObject:temdata];
        }];
        
    };
    
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn ug_radius:5];
    _saveBtn.backgroundColor = COLORPRIMARY;
    
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        
        if ([weakSelf updataData]) {
            
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            [realm transactionWithBlock:^{
                
                [SharesTargetData createOrUpdateInRealm:realm withValue:@{@"key": weakSelf.data.key,
                                                                          @"targetKey": weakSelf.contentTV.text,
                                                                          @"title": weakSelf.titleTF.text,
                                                                          @"remark": weakSelf.remarkTV.text,
                                                                          @"cotent": weakSelf.contentTV.text,
                                                                          @"valueType":weakSelf.options.count==0? @0:@1
                                                                          
                }];
                
                [self.view ug_msg:@"保存成功"];
            }];
        }
    }];
}

-(TargetOptionAddView *)targetOptionAddView{
    if (!_targetOptionAddView) {
        _targetOptionAddView = [TargetOptionAddView new];
        //添加选项卡
        UG_WEAKSELF
        [_targetOptionAddView.commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            SharesTargetOption *option = [SharesTargetOption new];
            option.title = weakSelf.targetOptionAddView.titleTF.text;
            option.remark = weakSelf.targetOptionAddView.remarkTV.text;
            option.value = weakSelf.targetOptionAddView.valueTV.text;
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            [realm transactionWithBlock:^{
                
                NSString *key = weakSelf.targetOptionAddView.editData.key?:[weakSelf.targetOptionAddView.editData makeKey];
                NSDictionary*dic = @{@"key": key,
                                     @"targetKey":weakSelf.data.key,
                                     @"title": weakSelf.targetOptionAddView.titleTF.text,
                                     @"remark": weakSelf.targetOptionAddView.remarkTV.text,
                                     @"value": weakSelf.targetOptionAddView.valueTV.text
                };
                [SharesTargetOption createOrUpdateInRealm:realm withValue:dic];
                [self.persent dismissViewControllerAnimated:YES completion:^{
                    [self.view ug_msg:@"保存成功"];
                    [weakSelf reloadOptionData];
                }];
               
            }];
            
        }];
    }
    return _targetOptionAddView;
}

-(BOOL)updataData{
    _titleTF.titlaLabel.textColor = COLOR23;
    _remarkTV.titlaLabel.textColor = COLOR23;
    _contentTV.titlaLabel.textColor = COLOR23;
    
    if (_titleTF.text.length == 0) {
        
        _titleTF.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    
    if (_remarkTV.text.length == 0) {
        
        _remarkTV.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    
    if (_contentTV.text.length == 0) {
        _contentTV.titlaLabel.textColor = COLORDANGER;
        return NO;
    }
    return YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollerView).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(60);
    }];
    [_remarkTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTF.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(80);
    }];
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remarkTV.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(150);
    }];
    
    [_targetOptionHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTV.mas_bottom).mas_offset(KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
    [_blockTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.targetOptionHeadView.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(_blockTableView.contentSize.height);
        make.bottom.mas_equalTo(self.scrollerView.mas_bottom).mas_offset(-68);
    }];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
        make.height.mas_equalTo(44);
    }];
}

@end
