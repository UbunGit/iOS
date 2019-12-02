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


@interface SharesTargetSettingVC ()

@property(strong, nonatomic) UIScrollView *scrollerView;
@property(strong, nonatomic) UGRemarkView *titleTF;
@property(strong, nonatomic) UGRemarkView *remarkTV;
@property(strong, nonatomic) UGRemarkView *contentTV;
@property(strong, nonatomic) TargetOptionHeadView* targetOptionHeadView;
@property(strong, nonatomic) BlockTableView *blockTableView;

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
    }else{
        _titleTF.text = _data.title;
        _remarkTV.text = _data.remark;
        _contentTV.text = _data.cotent;
    }
}
-(void)configUI{
    self.title = @"编辑属性";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.scrollerView = [UIScrollView new];
    [self.view addSubview:_scrollerView];
    _scrollerView.backgroundColor = UIColor.yellowColor;
    
    self.titleTF = [UGRemarkView new];
    [_scrollerView addSubview:_titleTF];
    _titleTF.titlaLabel.text = @"指标名称";
    
    self.remarkTV = [UGRemarkView new];
    [_scrollerView addSubview:_remarkTV];
    _remarkTV.titlaLabel.text = @"指标描述";
    
    self.contentTV = [UGRemarkView new];
    [_scrollerView addSubview:_contentTV];
    _contentTV.titlaLabel.text = @"指标规则";
    
    self.targetOptionHeadView = [TargetOptionHeadView new];
    [self.view addSubview:_targetOptionHeadView];
    
    _blockTableView = [BlockTableView new];
    [_scrollerView addSubview:_blockTableView];
    [_blockTableView ug_radius:5];
    
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return 5;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: @"cellid"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = @"==";
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 44;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
    };
    _blockTableView.commitEditingStyle = ^(UITableView * _Nonnull tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath * _Nonnull indexPath) {
        
      
    };
    _blockTableView.backgroundColor = UIColor.ug_random;
    
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn ug_radius:5];
    _saveBtn.backgroundColor = COLORPRIMARY;
    
    UG_WEAKSELF
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        
        if ([weakSelf updataData]) {
           
         
            RLMRealm *realm = [RLMRealm defaultRealm];
               
            [realm transactionWithBlock:^{
                NSString *key = weakSelf.data.key?:[weakSelf.data makeKey];
                [SharesTargetData createOrUpdateInRealm:realm withValue:@{@"key": key,
                                                                          @"title": weakSelf.titleTF.text,
                                                                          @"remark": weakSelf.remarkTV.text,
                                                                          @"cotent": weakSelf.contentTV.text,
                                                                          @"valueType":@0
                                                                          
                }];
              
                [self.view ug_msg:@"保存成功"];
            }];
        }
    }];
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
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.targetOptionHeadView.mas_bottom).mas_offset(KPAND_DEF);
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
