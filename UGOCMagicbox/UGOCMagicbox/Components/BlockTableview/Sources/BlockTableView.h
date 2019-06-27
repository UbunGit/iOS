//
//  BlockTableView.h
//  UbunGit_OC
//
//  Created by admin on 2019/6/25.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableview;

@property(copy, nonatomic) NSInteger (^numberOfSectionsInTableView)(UITableView *tableView); //defual 1
@property(copy, nonatomic) UITableViewCell * (^cellForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath); //defual UITableViewCell
@property(copy, nonatomic) NSInteger (^numberOfRowsInSection)(UITableView* tableView, NSInteger section);//defual 0
@property(copy, nonatomic) CGFloat (^heightForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);//defual 44
@property(copy, nonatomic) CGFloat (^heightForHeaderInSection)(UITableView* tableView, NSInteger section);//defual 0
@property(copy, nonatomic) CGFloat (^heightForFooterInSection)(UITableView* tableView, NSInteger section);//defual 0
@property(copy, nonatomic) UIView* (^viewForHeaderInSection)(UITableView* tableView, NSInteger section);//defual nil
@property(copy, nonatomic) UIView* (^viewForFooterInSection)(UITableView* tableView, NSInteger section);//defual nil


@property(copy, nonatomic) void (^didSelectRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);




@end

NS_ASSUME_NONNULL_END
