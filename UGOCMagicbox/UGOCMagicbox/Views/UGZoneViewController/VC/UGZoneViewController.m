//
//  UGZoneViewController.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGZoneViewController.h"
#import "BlockTableView.h"
#import "UGZoneData.h"
#import "UGZoneTableCell.h"

static NSString *cellID = @"UGZoneTableCell";
@interface UGZoneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableview;
@property(strong, nonatomic) NSArray *dataList;
@end

@implementation UGZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
    [self initData];
}

-(void)initData{
    NSMutableArray *temlist = [NSMutableArray array];
    for (NSInteger i=0 ; i<20; i++) {
        UGZoneData *data = [UGZoneData new];
        data.headimg = @"https://github.com/UbunGit/TestImage/blob/master/animal/0.jpg?raw=true";
        data.nick = @"哆啦A梦🚪";
        data.comment = @"红松子生产地区地势平坦，土壤类型以粘质壤土为主，有机 质丰富，保墒性能好。大荔冬枣肉细嫩，果肉乳白色或口感 细嫩酥脆，味道香甜";
        if (i%2 == 1) {
            UGZoneSourctData *sdata = [UGZoneSourctData new];
            sdata.imageurl = @"https://github.com/UbunGit/TestImage/blob/master/animal/0.jpg?raw=true";
            sdata.type = 1;
            data.sourctArr = @[sdata];
        }else{
            NSMutableArray *tmpArray = [NSMutableArray array];
            for (NSInteger j=0 ; j<random()%8; j++) {
                UGZoneSourctData *sdata = [UGZoneSourctData new];
                sdata.imageurl = @"https://github.com/UbunGit/TestImage/blob/master/animal/0.jpg?raw=true";
                sdata.type = 0;
                [tmpArray addObject:sdata];
            }
            data.sourctArr = tmpArray;
        }
        [temlist addObject:data];
        
    }
    self.dataList = temlist;
    [self bk_performBlock:^(id obj) {
          [_tableview reloadData];
    } afterDelay:0.1];
  
    
}

-(void)configUI{
    
    self.title = @"朋友圈";
    self.view.backgroundColor = COLORF0F2F5;
    
    self.tableview = [UITableView new];
    [self.view addSubview:_tableview];
    _tableview.delegate =self;
    _tableview.dataSource =self;
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.tableFooterView = [UIView new];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [self bk_performBlock:^(id obj) {
        [self viewWillLayoutSubviews];
    } afterDelay:1];
    return 1;

}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UGZoneTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UGZoneTableCell alloc] initWithStyle: UITableViewCellStyleDefault
                                      reuseIdentifier: cellID];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UGZoneData *data = [_dataList objectAtIndex:indexPath.row];
    [cell reload:data];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
            UIView *aview = [UIView new];
            [self.view ug_persentView:aview];
            aview.backgroundColor = UIColor.whiteColor;
            [aview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(aview.superview.mas_bottom);
                make.left.mas_equalTo(aview.superview);
                make.right.mas_equalTo(aview.superview);
                make.height.mas_equalTo(300);
            }];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}



@end
