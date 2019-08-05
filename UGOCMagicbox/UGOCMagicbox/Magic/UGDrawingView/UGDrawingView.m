//
//  UGDrawingView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/8.
//  Copyright © 2019 UG. All rights reserved.
//

#import "UGDrawingView.h"

@interface UGDrawingView()
// 声明一条贝塞尔曲线
@property(nonatomic, strong) UIBezierPath *bezier;

// 用来记录已有线条
@property (nonatomic, strong) NSMutableArray *allLines;

// 用来记录一次绘制时的所有点
@property (nonatomic, strong) NSMutableArray *points;

// 创建一个存储后退操作记录的数组
@property(nonatomic, strong) NSMutableArray *cancleArr;

@end


@implementation UGDrawingView
-(instancetype)init{
    if (self == [super init]) {
        self.color = [UIColor blackColor];
        self.lineWidth = 1;
        self.allLines = [NSMutableArray new];
        self.points = [NSMutableArray new];
        self.isEnable = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_isEnable) {
        return;
    }
    // 贝塞尔曲线
    self.bezier = [UIBezierPath bezierPath];
    [self.points removeAllObjects];
    // 获取触摸的点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    // 设置贝塞尔起点
    [self.bezier moveToPoint:point];
   
    
    // 在字典保存每条线的数据
    NSMutableDictionary *tempDic = [NSMutableDictionary new];
    [tempDic setObject:self.color forKey:@"color"];
    [tempDic setObject:[NSNumber numberWithFloat:self.lineWidth] forKey:@"lineWidth"];
    [tempDic setObject:self.bezier forKey:@"line"];
    
    // 存入线
    [self.allLines addObject:tempDic];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_isEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.bezier addLineToPoint:point];
    [self.points addObject:NSStringFromCGPoint(point)];
    //重绘界面
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self doBack];
    
    if (self.onecepand) {
        _onecepand(_points);
    }
}

- (void)drawRect:(CGRect)rect {

    for (int i = 0; i < self.allLines.count; i++) {
        
        NSDictionary *temDic = self.allLines[i];
        UIColor *color = temDic[@"color"];
        CGFloat width = [temDic[@"lineWidth"] floatValue];
        UIBezierPath *path = temDic[@"line"];
        
        [color setStroke];
        [path setLineWidth:width];
        [path stroke];
    }
}

-(void)drawyuan{
    
    CGPoint firstp = CGPointFromString([_points firstObject]);
    CGFloat minx = firstp.x;
    CGFloat maxx = firstp.x;
    CGFloat miny = firstp.y;
    CGFloat maxy = firstp.y;
    for (NSString *pointstr in _points) {
        CGPoint point = CGPointFromString(pointstr);
        minx = MIN(point.x, minx);
        miny = MIN(point.y, miny);
        maxx = MAX(point.x, maxx);
        maxy = MAX(point.y, maxy);
    }
    CGFloat rasdio = MAX(maxx-minx, maxy-miny);
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(minx, miny, rasdio, rasdio)];
    [path fill];
    [[UIColor blueColor] setStroke];
    [path setLineWidth:1];
    [path stroke];

}

//返回上一步
- (void)doBack {
    
    if (self.allLines.count > 0) {
        NSInteger index = self.allLines.count - 1;
        [self.cancleArr addObject:self.allLines[index]];
        [self.allLines removeObjectAtIndex:index];
        [self setNeedsDisplay];
    }
}

- (void)doForward {
    
    if (self.cancleArr.count > 0) {
        NSInteger index = self.cancleArr.count - 1;
        [self.allLines addObject:self.cancleArr[index]];
        [self.cancleArr removeObjectAtIndex:index];
        [self setNeedsDisplay];
    }
}

@end
