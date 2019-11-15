//
//  DorAnimationTestVC.m
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DorAnimationTestVC.h"
#import "BlockTableView.h"

#import "UGSpeekView.h"
@implementation AnimationData

@end

@interface DorAnimationTestVC ()
@property(strong, nonatomic) BlockTableView *blocktableview;
@property(strong, nonatomic) NSArray *dataList;
@end

@implementation DorAnimationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configUI];
    
}
-(void)initData{
    AnimationData *data1 = [AnimationData new];
    data1.title = @"animationflash";
    data1.des = @"图片y，centenX不变，缩小到一定比例";
    
    AnimationData *data2 = [AnimationData new];
    data2.title = @"水波";
    data2.des = @"带有波形效果的UI控件";
    
    AnimationData *data3 = [AnimationData new];
    data3.title = @"抖动";
    data3.des = @"带有波形效果的UI控件";
    
    self.dataList = @[data1,data2,data3];
}

-(void)configUI{
    self.title = @"常见动画";
    /*
     * 导航栏返回Btn
     */
    UIButton *itemButtom = [UIButton  buttonWithType:UIButtonTypeContactAdd];
    [itemButtom setFrame:CGRectMake(0, 0, 30, 40)];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithCustomView:itemButtom];
    [self.navigationItem setRightBarButtonItems:@[button]];
    self.view.backgroundColor = COLORF0F2F5;
    
    self.blocktableview = [BlockTableView new];
    [self.view addSubview:_blocktableview];
    
    UG_WEAKSELF
    _blocktableview.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
        return weakSelf.dataList.count;
    };
    _blocktableview.heightForRowAtIndexPath = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return 60;
    };
    
    
    _blocktableview.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                          reuseIdentifier: @"defualcell"];
            cell.detailTextLabel.numberOfLines = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = FONT_SYS16;
        }
        
        
        AnimationData* data = [weakSelf.dataList objectAtIndex:indexPath.row];
        cell.textLabel.text = data.title;
        cell.detailTextLabel.text = data.des;
        
        return cell;
    };
    _blocktableview.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        AnimationData* data = [weakSelf.dataList objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0:{
                
                UGSpeekView *aview = [[UGSpeekView alloc] initWithFrame:CGRectMake(0, 0, KAutoAcale(287), KAutoAcale(186))];
                [aview setCenter:weakSelf.view.center];
                [weakSelf.view addSubview:aview];
                for (NSInteger i=0; i<3; i++) {
                    UIColor *reamcolor = UIColor. ug_random;
                    UGWave *wave = [[UGWave alloc] initWithStyle:random()%2
                                                       direction:random()%255
                                                       amplitude:10.0f
                                                           width:KWidth/2
                                                       lineWidth:2.0f
                                                         offsetX:10.0f
                                                           stepX:8.0
                                                    layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                        waveLayer.backgroundColor = UIColor.clearColor.CGColor;
                        waveLayer.fillColor = reamcolor.CGColor;
                        waveLayer.strokeColor = reamcolor.CGColor;
                        return waveLayer;
                    }];
                    [aview.waverView addWaves:@[wave]];
                }
                
                [aview.waverView start];
                [aview.waverView setBackgroundColor:UIColor.clearColor];
                [weakSelf bk_performBlock:^(id obj) {
                    [aview.contentView ug_animationflashwithBlock:^(BOOL flag, CAAnimation * _Nonnull anim) {
                        [aview ug_animationPathwithBlock:^(BOOL flag, CAAnimation * _Nonnull anim) {
                            [aview removeFromSuperview];
                        }];
                    }];
                } afterDelay:10];
            }
                break;
            case 1:{
                
                UGWaverView *waveView = [[UGWaverView alloc] initWithFrame:CGRectMake(0.0f, 45.0f, KWidth, 55.0f)];
                
                [waveView setCenter:weakSelf.view.center];
                [weakSelf.view addSubview:waveView];
                for (NSInteger i=0; i<3; i++) {
                    UIColor *reamcolor = UIColor. ug_random;
                    UGWave *wave = [[UGWave alloc] initWithStyle:random()%2
                                                       direction:random()%255
                                                       amplitude:10.0f
                                                           width:KWidth/2
                                                       lineWidth:2.0f
                                                         offsetX:10.0f
                                                           stepX:8.0
                                                    layerCreator:^CALayer *(CAShapeLayer *waveLayer) {
                        waveLayer.backgroundColor = UIColor.clearColor.CGColor;
                        waveLayer.fillColor = reamcolor.CGColor;
                        waveLayer.strokeColor = reamcolor.CGColor;
                        return waveLayer;
                    }];
                    [waveView addWaves:@[wave]];
                }
                [waveView start];
            }break;
            case 2:{
                
                UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0, 88, 88)];
                
                [aview setCenter:weakSelf.view.center];
                [weakSelf.view addSubview:aview];
                aview.backgroundColor = UIColor.redColor;
                [aview ug_animationshakewithBlock:^(BOOL flag, CAAnimation * _Nonnull anim) {
                    [aview removeFromSuperview];
                }];
               
            }break;
                
                
            default:
                break;
        }
        
        
        
        
    };
    _blocktableview.titleForDeleteConfirmationButtonForRowAtIndexPath = ^NSString * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath* indexPath) {
        return @"删除";
    };
    _blocktableview.commitEditingStyle = ^(UITableView * _Nonnull tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath * _Nonnull indexPath) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
        }
    };
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [_blocktableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}
@end
