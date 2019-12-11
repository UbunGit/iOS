//
//  DanMushowView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 UG. All rights reserved.
//

#import "DanMushowView.h"

@implementation DanMushowView{
    NSInteger gtime;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gloableTimerdoit) name:@"GloableTimer" object:nil];
        [self confitUI];
    }
    return self;
}

-(void)confitUI{
    self.barrageManager = [OCBarrageManager new];
    [self addSubview:_barrageManager.renderView];
    [_barrageManager start];
}

-(void)gloableTimerdoit{
    
    if (self.hidden) {
        return;
    }
    gtime++;
    if (gtime>3) {
        gtime =0;
        NSObject *obj = [_listarr firstObject];
        DDLogVerbose(@"remove begin:%@",_listarr);
        [self addAnimationCell:obj];
        [_listarr removeObject:obj];
        DDLogVerbose(@"remove end:%@",_listarr);
    }
    if(_listarr.count<=0){//如果没有数据了就不删除了
        [self getdataList];
    }
}
- (void)addAnimationCell:(NSObject*)obj {
    
    DanmuManDescriptor *bannerDescriptor = [[DanmuManDescriptor alloc] init];
    bannerDescriptor.cellTouchedAction = ^(OCBarrageDescriptor *__weak descriptor, OCBarrageCell *__weak cell) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OCBarrage" message:@"全民超人为您服务" delegate:nil cancelButtonTitle:@"朕知道了" otherButtonTitles:nil];
        [alertView show];
        
        DanmuManCell *walkBannerCell = (DanmuManCell *)cell;
        walkBannerCell.textLabel.backgroundColor = [UIColor redColor];
    };
    NSString *str = (NSString*)obj;
    bannerDescriptor.text = str.length==0?@" ":str;
    bannerDescriptor.textColor = UIColor.whiteColor;
    bannerDescriptor.textFont = FONT_SYS14;
    bannerDescriptor.positionPriority = OCBarragePositionMiddle;
    bannerDescriptor.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    bannerDescriptor.strokeWidth = -1;
    bannerDescriptor.animationDuration = arc4random()%5 + 5;
    bannerDescriptor.barrageCellClass = [DanmuManCell class];
    [self.barrageManager renderBarrageDescriptor:bannerDescriptor];
}
-(void)getdataList{
    
    self.listarr = [[NSMutableArray alloc]initWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    //    [[NetworkTools shareTools] getStickVideoInfoTop5:^(NSDictionary * _Nonnull dictionary, NSError * _Nonnull error) {
    //        if(error){
    //            return ;
    //        }else{
    //            self.dataarr = [NSArray modelArrayWithClass:[VideoModel class] json:[dictionary objectForKey:@"data"]];
    //            self->showarr = [[NSMutableArray alloc]initWithArray:self.dataarr];
    //        }
    //    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_barrageManager.renderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

@end
