//
//  LOTViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/8/20.
//  Copyright © 2019 UG. All rights reserved.
//

#import "LOTViewController.h"
#import <Lottie.h>

@interface LOTViewController ()<LOTValueDelegate>
@property(strong, nonatomic) LOTAnimationView *favor;
@property(strong, nonatomic) UIButton *starBtn;
@end

@implementation LOTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    self.favor = [LOTAnimationView animationNamed:@"data"];
    _favor.loopAnimation = NO;
    _favor.contentMode=UIViewContentModeScaleAspectFill;
    _favor.animationSpeed = 0.8;
    [self.view addSubview:_favor];
    LOTKeypath *toKeypath = [LOTKeypath keypathWithString:@"dizhibg"];
    UILabel * alable1= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 720)];
    alable1.text = @"999你出不出来·";
    alable1.backgroundColor = UIColor.yellowColor;

    [_favor playWithCompletion:^(BOOL animationFinished) {
//        [_favor maskSubview:alable1 toKeypathLayer:toKeypath];
    }];
    [_favor setValueDelegate:self forKeypath:toKeypath];


  
  

    self.starBtn = [UIButton new];
    [self.view addSubview:_starBtn];
    [_starBtn setTitle:@"网络" forState:UIControlStateNormal];
    [_starBtn setBackgroundColor:UIColor.ug_random];
    [_starBtn bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    
    [self.favor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-120);
        
    }];

    [_starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(-55);
        make.height.mas_equalTo(44);
    }];
 
}

@end
