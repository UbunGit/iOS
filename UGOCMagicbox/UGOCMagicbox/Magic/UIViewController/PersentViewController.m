//
//  PersentViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 UG. All rights reserved.
//

#import "PersentViewController.h"

@interface PersentViewController ()<UIGestureRecognizerDelegate>

@end

@implementation PersentViewController
-(instancetype)init{
    if (self == [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.view.backgroundColor = COLOR00_04;
    
    
    UG_WEAKSELF
    UITapGestureRecognizer *gestureRecognizerg = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
    gestureRecognizerg.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizerg];
   
    NSString *bcaktitle = [NSString fontAwesomeIconStringForEnum:FADotCircleO];
    self.closeBtn = [UIButton new];
    [_closeBtn.titleLabel setFont:FONT_FA20];
    [_closeBtn.titleLabel setTextColor:COLOR23];
    [_closeBtn setTitle:bcaktitle forState:UIControlStateNormal];
    [_closeBtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    if (_cotentView) {
        [self.view addSubview:_cotentView];
         [self.view addSubview:_closeBtn];
        if(_type==0){
            [_cotentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view.centerY).mas_offset(-80);
                make.left.mas_equalTo(self.view).mas_offset(KPAND_DEF);
                make.right.mas_equalTo(self.view).mas_offset(-KPAND_DEF);
            }];
            [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.cotentView.mas_top).mas_offset(-KPAND_DEF);
                make.right.mas_equalTo(self.cotentView).mas_offset(-KPAND_DEF);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }else{
            [_cotentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.view);
                make.left.mas_equalTo(self.view);
                make.right.mas_equalTo(self.view);
            }];
        }
        
    }

}
#pragma mark- --点击手势代理，为了去除手势冲突--
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isEqual:self.view]) {
        return YES;
    }else{
       return NO;
    }
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];


}


@end
