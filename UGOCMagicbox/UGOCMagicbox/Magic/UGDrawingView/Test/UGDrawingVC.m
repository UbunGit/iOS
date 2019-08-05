//
//  DorUGDrawingVC.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/8.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGDrawingVC.h"
#import "UGDrawingView.h"


@interface UGDrawingVC ()

@property(strong, nonatomic) UGDrawingView *drawview;

@end

@implementation UGDrawingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

-(void)configUI{
    self.drawview = [UGDrawingView new];
    _drawview.backgroundColor = UIColor.ug_random;
    [self.view addSubview:_drawview];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_drawview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
