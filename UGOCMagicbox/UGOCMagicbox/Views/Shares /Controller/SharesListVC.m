//
//  SharesListVC.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesListVC.h"

#import "PersentViewController.h"
#import "SharesAddView.h"
#import "SharesViewController.h"
#import "NetWorkRequest+Shares.h"
#import "SharesHistoryData.h"
#import "SharesViewController.h"
#import "SharesTargetListVC.h"
#import "SharesResuleVC.h"
#import "ShareHistoryCell.h"
#import "SharesToolView.h"
#import "UIAppdelegate+Realm.h"

@interface SharesListVC ()
@property(strong, nonatomic) SharesAddView*sharesAddView;
@property(strong, nonatomic) PersentViewController *persent;
@property(strong, nonatomic) RLMResults<SharesHistoryData *> *datalist; //历史测评记录
@property(strong, nonatomic) BlockTableView *blockTableView;
@property(strong, nonatomic) SharesToolView *sharesToolView;
@end

@implementation SharesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updataData];
}
-(void)updataData{
    RLMResults *temresult= [SharesHistoryData allObjects];
    _datalist = [temresult sortedResultsUsingKeyPath:@"edittime" ascending:YES];
    [_blockTableView reloadData];
}

-(void)configUI{
     UG_WEAKSELF
    self.title = @"测评历史";
    //导航拦
    UIButton *itemButtom0 = [UIButton  new];
    [itemButtom0 setFrame:CGRectMake(0, 0, 30, 40)];
    NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FACog];
    [itemButtom0.titleLabel setFont:FONT_FA20];
    [itemButtom0 setTitleColor:COLORINFO forState:UIControlStateNormal];
    [itemButtom0 setTitle:bcaktitle forState:UIControlStateNormal];
    [itemButtom0 ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        self.persent = [PersentViewController new];
        weakSelf.persent.cotentView = self.sharesToolView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    }];
    UIBarButtonItem *button0 = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom0];
    
    UIButton *itemButtom = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [itemButtom setTitleColor:COLORINFO forState:UIControlStateNormal];
    [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    [itemButtom ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        
        self.persent = [PersentViewController new];
        weakSelf.persent.cotentView = self.sharesAddView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    }];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
    

    [self.navigationItem setRightBarButtonItems:@[button0,button]];
   
    self.blockTableView = [BlockTableView new];
    [self.view addSubview:_blockTableView];
    _blockTableView.estimatedRowHeight = 100;
    _blockTableView.rowHeight = UITableViewAutomaticDimension;
    
    _blockTableView.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return weakSelf.datalist.count;
    };
    _blockTableView.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        
        ShareHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareHistoryCell"];
        if (cell == nil) {
            cell = [[ShareHistoryCell alloc] initWithStyle: UITableViewCellStyleDefault
                                          reuseIdentifier: @"ShareHistoryCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        SharesHistoryData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@:%zd",data.name, data.number,data.date];
        [cell reload:data];
        return cell;
    };
    _blockTableView.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 120;
    };
    _blockTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        SharesHistoryData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
        NSData *filedata = [[NSFileManager defaultManager] contentsAtPath:data.absfilePath];
        if(filedata){
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:filedata options:NSJSONReadingMutableLeaves error:nil];
            
            SharesResuleVC *sharesViewController = [SharesResuleVC new];
            sharesViewController.sharesdata = data;
            sharesViewController.editDic = [dic objectForKey:@"data"];
            sharesViewController.remarkDic = [dic objectForKey:@"remark"];
            [weakSelf.navigationController pushViewController:sharesViewController animated:YES];
        }else{
            [weakSelf.view ug_msg:@"文件不存在或丢失"];
            RLMRealm *realm = [RLMRealm defaultRealm];
            // 删除单个模型
            [realm transactionWithBlock:^{
               [realm deleteObject:data];
                [weakSelf updataData];
            }];
        }
     
        
    };
    _blockTableView.commitEditingStyle = ^(UITableView * _Nonnull tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath * _Nonnull indexPath) {
        
        SharesHistoryData *data = [weakSelf.datalist objectAtIndex:indexPath.row];
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        [defaultManager removeItemAtPath:data.absfilePath error:nil];
        RLMRealm *realm = [RLMRealm defaultRealm];
        // 删除单个模型
        [realm transactionWithBlock:^{
            [realm deleteObject:data];
            [weakSelf updataData];
        }];
    };
}

/**
 添加测评股票
 */
-(SharesAddView *)sharesAddView{
    if (!_sharesAddView) {
        _sharesAddView = [SharesAddView new];
        UG_WEAKSELF
        [_sharesAddView.commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            weakSelf.sharesAddView.titleTF.titlaLabel.textColor = COLOR23;
            weakSelf.sharesAddView.numberTF.titlaLabel.textColor = COLOR23;
            weakSelf.sharesAddView.timeTF.titlaLabel.textColor = COLOR23;
            SharesHistoryData *data = weakSelf.sharesAddView.data;
            if (data.name.length==0) {
                weakSelf.sharesAddView.titleTF.titlaLabel.textColor = COLORDANGER;
                return ;
            }
            if (data.number.length==0) {
                weakSelf.sharesAddView.numberTF.titlaLabel.textColor = COLORDANGER;
                return ;
            }
            if (data.date==0) {
                weakSelf.sharesAddView.timeTF.titlaLabel.textColor = COLORDANGER;
                return ;
            }
            [weakSelf.persent dismissViewControllerAnimated:YES completion:nil];
            SharesViewController *sharesViewController = [SharesViewController new];
            sharesViewController.sharesdata = data;
            [self.navigationController pushViewController:sharesViewController animated:YES];
        }];
    }
    return _sharesAddView;
}

/**
 工具view
 */
-(SharesToolView *)sharesToolView{
    if (!_sharesToolView) {
        UG_WEAKSELF
        _sharesToolView = [SharesToolView new];
        // 指标
        [_sharesToolView.addtargetbtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [self.persent dismissViewControllerAnimated:YES completion:^{
                [self.navigationController pushViewController:[SharesTargetListVC new] animated:YES];
            }];
            
        }];
        // 上传数据库
        [_sharesToolView.gitupbtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [[NetWorkRequest share] createpath:@"Shares/default.realm" sha:[[UIApplication sharedApplication] getsha] block:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
                if (error) {
                    [self.persent.view ug_msg:error.domain];
                }else{
                    [[UIApplication sharedApplication] updateRealInfo:^(NSError * _Nonnull error, NSDictionary * _Nonnull result) {
                        if (!error) {
                            [self.persent dismissViewControllerAnimated:YES completion:^{
                                [self.view ug_msg:@"备份成功"];
                            }];
                        }else{
                            [self.persent.view ug_msg:@"备份失败"];
                        }
                    }];
                }
            }];
        }];
        // 下载数据库
        [_sharesToolView.gitdownbtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            weakSelf.sharesToolView.gitdownbtn.userInteractionEnabled = NO;
            [weakSelf.sharesToolView.gitdownbtn setTitle:[NSString stringWithFormat:@"0.00％"] forState:UIControlStateNormal];
            NSString *filepath = [NSString stringWithFormat:@"%@/shares/default1.realm",PATHDOCUMENT];
            [[NetWorkRequest share] download:[UIApplication sharedApplication].getDownurl filepath:filepath progress:^(NSProgress * _Nonnull downloadProgress) {
                DDLogVerbose(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.sharesToolView.gitdownbtn setTitle:[NSString stringWithFormat:@"%.0f％", downloadProgress.fractionCompleted * 100] forState:UIControlStateNormal];
                 });
            } head:nil endblock:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
                weakSelf.sharesToolView.gitdownbtn.userInteractionEnabled = YES;
                if (error) {
                 
                    [self.view ug_msg:error.domain];
                }else{
                    DDLogVerbose(@"文件下载成功地址：%@",[dataDict objectForKey:@"path"]);
                    [self.view ug_msg:@"成功"];
                }
            }];
        }];
    }
    return _sharesToolView;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_blockTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
