//
//  WelcomViewController.m
//  UbunGit_OC
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 admin. All rights reserved.
//

#import "WelcomViewController.h"
#import "Masonry.h"

@interface WelcomViewController ()<UIScrollViewDelegate>

@end

@implementation WelcomViewController
-(instancetype)init{
    if (self  == [super init]) {
        [self setUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView = [UIScrollView new];
    [self.view addSubview:_scrollerView];
    _scrollerView.bounces = NO;
    _scrollerView.pagingEnabled = YES;
    _scrollerView.delegate = self;
    _scrollerView.showsVerticalScrollIndicator = NO;
    
    self.welcombtn = [UIButton new];
    [self.view addSubview:_welcombtn];
    _welcombtn.backgroundColor = [UIColor colorWithRed:((float)((0x1AC6D3 & 0xFF0000) >> 16))/255.0
                                                 green:((float)((0x1AC6D3 & 0xFF00) >> 8))/255.0
                                                  blue:((float)(0x1AC6D3 & 0xFF))/255.0 alpha:1.0];
    _welcombtn.layer.cornerRadius = 15;
    _welcombtn.layer.masksToBounds = YES;
    _welcombtn.hidden = YES;
    [_welcombtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_welcombtn setTitle:@"立即开启" forState:UIControlStateNormal];
    [_welcombtn addTarget:self action:@selector(gotoNext:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelbtn = [UIButton new];
    [self.view addSubview:_cancelbtn];
    UIColor *titleColoe = [UIColor colorWithRed:((float)((0x666666 & 0xFF0000) >> 16))/255.0
                                          green:((float)((0x666666 & 0xFF00) >> 8))/255.0
                                           blue:((float)(0x666666 & 0xFF))/255.0 alpha:1.0];
    [_cancelbtn setTitleColor:titleColoe forState:UIControlStateNormal];
    _cancelbtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [_cancelbtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_cancelbtn addTarget:self action:@selector(gotoNext:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageControl = [UIPageControl new];
    [self.view addSubview:_pageControl];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:((float)((0x1AC6D3 & 0xFF0000) >> 16))/255.0
                                                          green:((float)((0x1AC6D3 & 0xFF00) >> 8))/255.0
                                                           blue:((float)(0x1AC6D3 & 0xFF))/255.0 alpha:1.0];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:((float)((0xDBDBDB & 0xFF0000) >> 16))/255.0
                                                                 green:((float)((0xDBDBDB & 0xFF00) >> 8))/255.0
                                                                  blue:((float)(0xDBDBDB & 0xFF))/255.0 alpha:1.0];
    

    
    
}
-(void)setImageArr:(NSArray *)imageArr{
    if (imageArr) {
        _imageArr = imageArr;
        UIView *temview = nil;
        for (NSString * imagestr in imageArr) {
            UIImageView *aimage = [UIImageView new];
            [_scrollerView addSubview:aimage];
            aimage.contentMode = UIViewContentModeScaleAspectFill;
            aimage.clipsToBounds = YES;
            [aimage setImage:[UIImage imageNamed:imagestr]];
            
            if (temview) {
                [aimage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.scrollerView);
                    make.left.mas_equalTo(temview.mas_right);
                    make.height.mas_equalTo(self.scrollerView.mas_height);
                    make.width.mas_equalTo(self.scrollerView.mas_width);
                }];
            }else{
                [aimage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.scrollerView);
                    make.left.mas_equalTo(self.scrollerView);
                    make.height.mas_equalTo(self.scrollerView.mas_height);
                    make.width.mas_equalTo(self.scrollerView.mas_width); 
                }];
            }
            temview = aimage;
        }
        _pageControl.numberOfPages = imageArr.count;
        _pageControl.currentPage = 0;
        [temview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.scrollerView.mas_right);
        }];
    }
 
}

-(void)gotoNext:(UIButton*)sender{
    if (_endBlock) {
        _endBlock(sender);
    }
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
    }];
    [_welcombtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(112);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
    }];
    [_cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(8+[[UIApplication sharedApplication] statusBarFrame].size.height);
    }];
    
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {

    CGFloat pageWidth = sender.frame.size.width;
    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage == _imageArr.count-1) {
        _pageControl.hidden = YES;
         _cancelbtn.hidden = YES;
        _welcombtn.hidden = NO;
    }else{
        _welcombtn.hidden = YES;
        _cancelbtn.hidden = NO;
        _pageControl.hidden = NO;
    }
    _pageControl.currentPage = currentPage;
}

@end
