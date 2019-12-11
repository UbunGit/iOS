//
//  DanmuViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/10.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DanmuViewController.h"

#import "PersentViewController.h"
#import "DamuSendView.h"
#import "OCBarrage.h"

#import "DanmuManCell.h"


@interface DanmuViewController ()
@property(strong, nonatomic) UIButton *sendBtn;
@property(strong, nonatomic) PersentViewController *persent;
@property (nonatomic, strong) OCBarrageManager *barrageManager;
@property (nonatomic, strong) DamuSendView *damuSendView;
@end

@implementation DanmuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.sendBtn = [UIButton new];
    [_sendBtn setTitle:@"发送弹幕" forState:UIControlStateNormal];
    [_sendBtn setBackgroundColor:COLORDANGER];
    [_sendBtn ug_radius:5];
    [self.view addSubview:_sendBtn];
    UG_WEAKSELF
    [_sendBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
   
        weakSelf.persent.cotentView = self.damuSendView;
        [weakSelf presentViewController:weakSelf.persent animated:YES completion:nil];
    }];
    
    self.barrageManager = [OCBarrageManager new];
//    _barrageManager.renderView.frame = CGRectMake(0.0, 64, KWidth, 100);
//    _barrageManager.renderView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:_barrageManager.renderView];
    [_barrageManager start];
}
-(PersentViewController *)persent{
    
    if (!_persent) {
        _persent = [PersentViewController new];
        _persent.type = 1;
    }
    return _persent;
}
-(DamuSendView *)damuSendView{
    if (!_damuSendView) {
        _damuSendView = [DamuSendView new];
        [_damuSendView.inputView.sendBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
            [self addFixedSpeedAnimationCell];
        }];
    }
    return _damuSendView;
}


- (void)addFixedSpeedAnimationCell {
    

    DanmuManDescriptor *bannerDescriptor = [[DanmuManDescriptor alloc] init];
      bannerDescriptor.cellTouchedAction = ^(OCBarrageDescriptor *__weak descriptor, OCBarrageCell *__weak cell) {
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OCBarrage" message:@"全民超人为您服务" delegate:nil cancelButtonTitle:@"朕知道了" otherButtonTitles:nil];
          [alertView show];
          
          DanmuManCell *walkBannerCell = (DanmuManCell *)cell;
          walkBannerCell.textLabel.backgroundColor = [UIColor redColor];
      };
      
      bannerDescriptor.text = [NSString stringWithFormat:@"~欢迎全民超人大驾光临~"];
      bannerDescriptor.textColor = UIColor.whiteColor;
      bannerDescriptor.textFont = FONT_SYS14;
      bannerDescriptor.positionPriority = OCBarragePositionMiddle;
//      bannerDescriptor.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
      bannerDescriptor.strokeWidth = -1;
      bannerDescriptor.animationDuration = arc4random()%5 + 5;
      bannerDescriptor.barrageCellClass = [DanmuManCell class];
      [self.barrageManager renderBarrageDescriptor:bannerDescriptor];
    
//    [self performSelector:@selector(addFixedSpeedAnimationCell) withObject:nil afterDelay:2];
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_equalTo(KPAND_DEF);
        make.right.mas_equalTo(self.view).mas_equalTo(-KPAND_DEF);
        make.bottom.mas_equalTo(self.view).mas_equalTo(-KPAND_DEF);
        make.height.mas_equalTo(40);
    }];
    
    [_barrageManager.renderView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.view);
         make.right.mas_equalTo(self.view);
         make.height.mas_equalTo(KAutoAcale(230));
         make.top.mas_equalTo(self.view).mas_offset(KPAND_DEF);
     }];
}
@end
