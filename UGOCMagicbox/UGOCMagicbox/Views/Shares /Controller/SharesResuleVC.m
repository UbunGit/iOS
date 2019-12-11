//
//  SharesResuleVC.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/25.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesResuleVC.h"

#import "SharesHistoryData.h"
#import "SharesTargetData.h"
#import "ShareRemarkView.h"
#import "PersentViewController.h"
#import "NetWorkRequest+Shares.h"
#import "NSData+YYAdd.h"
#import "SharesResultView.h"

@interface SharesResuleVC ()


@property(strong, nonatomic) UIButton *saveBtn;
@property(strong,nonatomic) NSDictionary *resultDic;
@property(strong, nonatomic) PersentViewController *persent;
@property(strong, nonatomic)ShareRemarkView *shareRemarkView;
@property(strong,nonatomic) SharesResultView *sharesResultView;
@end

@implementation SharesResuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self savedata];
}
-(void)configUI{
    self.title = @"测评结果";
    UG_WEAKSELF
    //添加测评
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"添加测评意见" forState:UIControlStateNormal];
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
         self.persent = [PersentViewController new];
         weakSelf.persent.cotentView = self.shareRemarkView;
        [self.shareRemarkView reload:[RemarkViewValue modelWithJSON:self.sharesResultView.remarkDic]];
         [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
      }];
    [_saveBtn ug_radius:5];
    [_saveBtn setBackgroundColor:COLORDANGER];
    
    //
    self.sharesResultView = [SharesResultView new];
    _sharesResultView.sharesdata = _sharesdata;
    [self.view addSubview:_sharesResultView];
    
    
}


-(void)savedata{
    UG_WEAKSELF
    NSMutableDictionary *savedic = [NSMutableDictionary new];
    [savedic setObject:self.sharesResultView.editDic forKey:@"data"];
    if (self.sharesResultView.remarkDic) {
        [savedic setObject:self.sharesResultView.remarkDic forKey:@"remark"];
    }

    NSString *oldfiledata = [[[NSFileManager defaultManager] contentsAtPath:_sharesdata.absfilePath] md5String];
    
    NSString *savestr = [savedic jsonStringEncoded];
    NSError *err = [[NSError alloc]init];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:_sharesdata.absfilePath error:nil];
    BOOL create =[defaultManager createDirectoryAtPath:_sharesdata.abspath withIntermediateDirectories:YES attributes:nil error:&err];
    if (!create) {
        [self.view ug_msg:@"文件夹创建失败"];
        return;
    }
    BOOL isok =[savestr writeToFile:_sharesdata.absfilePath atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (isok) {
        if (!_sharesdata.key) {
            SharesHistoryData *data = [SharesHistoryData new];
            data.key = [data makeKey];
            data.edittime = [[NSDate date] timeIntervalSince1970];
            data.date = _sharesdata.date;
            data.number = _sharesdata.number;
            data.name = _sharesdata.name;
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject: data];
                [self.view ug_msg:@"保存成功"];
            }];
             weakSelf.sharesdata = data;
        }else{
            [self.view ug_msg:@"修改成功"];
        }
        
        NSString *newfiledata = [[[NSFileManager defaultManager] contentsAtPath:_sharesdata.absfilePath] md5String];
        if (![newfiledata isEqualToString:oldfiledata]) {
            [[NetWorkRequest share] createpath:_sharesdata.relfilepath lpath:_sharesdata.absfilePath sha:_sharesdata.sha message:@"评测" block:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
                if (error) {
                    [self.view ug_msg:@"上传失败"];
                }else{
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm transactionWithBlock:^{
                        NSDictionary *dic = [dataDict objectForKey:@"content"];
                        weakSelf.sharesdata.isCommit = YES;
                        weakSelf.sharesdata.sha = [dic objectForKey:@"sha"];
                        weakSelf.sharesdata.downurl = [dic objectForKey:@"download_url"];
                        [self.view ug_msg:@"上传成功"];
                    }];
                }
            }];
        }
       

    }else{
        [self.view ug_msg:@"保存失败"];
    }
}

-(ShareRemarkView *)shareRemarkView{
    UG_WEAKSELF
    if (!_shareRemarkView) {
        _shareRemarkView = [ShareRemarkView new];
        [_shareRemarkView.commitBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            self.sharesResultView.remarkDic = [weakSelf.shareRemarkView.value modelToJSONObject];
            [weakSelf.persent dismissViewControllerAnimated:YES completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
    }
    return _shareRemarkView;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);;
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
    }];

    [_sharesResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.saveBtn.mas_top).mas_offset(-KPAND_DEF);
    }];
}
@end
