//
//  SuperPlayerVC.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "SuperPlayerVC.h"
#import <SuperPlayer/SuperPlayer.h>
@interface SuperPlayerVC ()<SuperPlayerDelegate>
@property(strong, nonatomic) SuperPlayerView *playerView;
@end

@implementation SuperPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber *temnum = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@SuperPlayerVC",_videoURL]];
    CGFloat temfloat = temnum.floatValue;
    _playerView = [[SuperPlayerView alloc] init];
    // 设置代理，用于接受事件
    _playerView.delegate = self;
    // 设置父View，_playerView会被自动添加到holderView下面
    _playerView.fatherView = self.view;
    [_playerView setStartTime:temfloat];
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    // 设置播放地址，直播、点播都可以
    playerModel.videoURL = _videoURL;
    // 开始播放
    [_playerView playWithModel:playerModel];
}
/** 返回事件 */
- (void)superPlayerBackAction:(SuperPlayerView *)player{
    NSNumber *numer = [NSNumber numberWithFloat:player.playCurrentTime];
    [[NSUserDefaults standardUserDefaults] setObject:numer forKey:[NSString stringWithFormat:@"%@SuperPlayerVC",_videoURL]];
    [player pause];
    [player resetPlayer];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

@end
