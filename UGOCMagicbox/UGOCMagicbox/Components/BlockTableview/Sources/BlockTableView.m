//
//  BlockTableView.m
//  UbunGit_OC
//
//  Created by admin on 2019/6/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import "BlockTableView.h"

@interface BlockTableView()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation BlockTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    self.tableview = [UITableView new];
    [self addSubview:_tableview];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_numberOfSectionsInTableView) {
        return _numberOfSectionsInTableView(tableView);
    }else{
        return 1;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (_cellForRowAtIndexPath) {
        return _cellForRowAtIndexPath(tableView,indexPath);
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = @"ceshi";
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_numberOfRowsInSection) {
        return _numberOfRowsInSection(tableView,section);
    }else{
        return 0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_didSelectRowAtIndexPath) {
        _didSelectRowAtIndexPath(tableView, indexPath);
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_heightForRowAtIndexPath) {
       return _heightForRowAtIndexPath(tableView, indexPath);
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_heightForHeaderInSection) {
       return _heightForHeaderInSection(tableView, section);
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_heightForFooterInSection) {
       return _heightForFooterInSection(tableView, section);
    }else{
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_viewForHeaderInSection) {
       return _viewForHeaderInSection(tableView, section);
    }else{
        return nil;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_viewForFooterInSection) {
      return  _viewForFooterInSection(tableView, section);
    }else{
        return nil;
    }
}
@end
