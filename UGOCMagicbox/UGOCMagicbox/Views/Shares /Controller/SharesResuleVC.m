//
//  SharesResuleVC.m
//  UGOCMagicbox
//
//  Created by MBA on 2019/11/25.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SharesResuleVC.h"

#import "SharesHistoryData.h"

@interface SharesResuleVC ()

@property(strong, nonatomic) UILabel *titleLab;

@property(strong, nonatomic) UIButton *saveBtn;
@property(strong, nonatomic) UIButton *cancleBtn;

@end

@implementation SharesResuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    
    self.titleLab = [UILabel new];
    [self.view addSubview:_titleLab];
    
    self.saveBtn = [UIButton new];
    [self.view addSubview:_saveBtn];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:COLORDANGER];
    
    [_saveBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [self savedata];
    }];
    
    self.cancleBtn = [UIButton new];
    [self.view addSubview:_cancleBtn];
    [_cancleBtn setTitle:@"放弃返回" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:COLORWARNING];
}

-(void)updateUI{
    
    _titleLab.text = [NSString stringWithFormat:@"测评结果\n%@ %@",_sharesdata.name,_sharesdata.number];
}

-(void)savedata{
    NSString *savestr = [_editDic jsonStringEncoded];
    DDLogVerbose(@"%@",savestr);
    NSString *fileName = _sharesdata.number;
    NSString *lpath = [NSString stringWithFormat:@"%zd",_sharesdata.date];
    NSMutableString *path = [NSMutableString stringWithString:PATHDOCUMENT];
    [path appendFormat:@"/shares/%@",lpath];
    
    NSString *filePaths =  [NSString stringWithFormat:@"%@/%@.json",path,fileName];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:path error:nil];
    [defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSError *err = [NSError new];
    BOOL isok =[savestr writeToFile:filePaths atomically:YES encoding:NSUTF8StringEncoding error:&err];
    
    if (isok) {
        SharesHistoryData *data = [SharesHistoryData new];
        data.edittime = [[NSDate date] timeIntervalSince1970];
        data.date = _sharesdata.date;
        data.number = _sharesdata.number;
        data.path = @"/shares";
        data.name = _sharesdata.name;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:data];
            [self.view ug_msg:@"保存成功"];
        }];
        
    }else{
        [self.view ug_msg:@"保存失败"];
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
    }];
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
          make.left.mas_equalTo(self.view.mas_centerX);
          make.bottom.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
      }];
}
@end
