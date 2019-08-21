//
//  SVGViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/8/16.
//  Copyright © 2019 UG. All rights reserved.
//

#import "SVGViewController.h"
#import <SVGAPlayer/SVGA.h>

@interface SVGViewController ()<SVGAPlayerDelegate>

@property(strong, nonatomic) SVGAPlayer *svgPlayer;

@property(strong, nonatomic) UIButton *starBtn;//网络svga
@property(strong, nonatomic) UIButton *locationBtn;//本地svga

@end

@implementation SVGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
-(void)configUI{
    __weak __typeof(self) weakself = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.svgPlayer = [SVGAPlayer new];
    _svgPlayer.loops = 1;
    [self.view addSubview:_svgPlayer];
    _svgPlayer.delegate = self;
    _svgPlayer.layer.borderWidth = 0.5;
    _svgPlayer.layer.borderColor = UIColor.ug_random.CGColor;
    
    self.starBtn = [UIButton new];
    [self.view addSubview:_starBtn];
    [_starBtn setTitle:@"网络" forState:UIControlStateNormal];
    [_starBtn setBackgroundColor:UIColor.ug_random];
    [_starBtn bk_addEventHandler:^(id sender) {
 
        SVGAParser *parser = [[SVGAParser alloc] init];
        [parser parseWithNamed:@"kingset" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            if (videoItem != nil) {
                
                weakself.svgPlayer.videoItem = videoItem;
                [weakself.svgPlayer startAnimation];
            }
        } failureBlock:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    self.locationBtn = [UIButton new];
    [self.view addSubview:_locationBtn];
    [_locationBtn setTitle:@"本地" forState:UIControlStateNormal];
    [_locationBtn setBackgroundColor:UIColor.ug_random];
    [_locationBtn bk_addEventHandler:^(id sender) {
        SVGAParser *parser = [[SVGAParser alloc] init];
        [parser parseWithNamed:@"feiji" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            if (videoItem != nil) {
        
                weakself.svgPlayer.videoItem = videoItem;
                [weakself.svgPlayer startAnimation];
            }
        } failureBlock:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"深圳"
                                                               attributes:@{
                                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:42.0],
                                                                            }];
    NSAttributedString *henfu = [[NSAttributedString alloc] initWithString:@"\t横幅区域文字"
                                                               attributes:@{
                                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:28.0],
                                                                            }];
   
    
    [weakself.svgPlayer setAttributedText:text forKey:@"dizhibg"];
    [weakself.svgPlayer setAttributedText:henfu forKey:@"hengfu"];
    [[[NSURLSession sharedSession] dataTaskWithURL:UGURL(@"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/1522738681.jpg") completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            UIImage *image = [UIImage imageWithData:data];
            if (image != nil) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [weakself.svgPlayer setImage:[image ug_cornerRadius:MAXFLOAT] forKey:@"touxiang"];
                }];
            }
        }
    }] resume];

}
-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    [_svgPlayer clear];
}
-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_svgPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-55);
        make.height.mas_equalTo(44);
    }];
}

@end
