//
//  UGWaverView.h
//  UGOCMagicbox
//
//  Created by xiaoqy on 2019/11/15.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - UGWaveStyle
typedef NS_ENUM(NSInteger, UGWaveStyle) {
    UGWaveStyleSin,         // 正弦曲线波形
    UGWaveStyleCos          // 余弦曲线波形
};

#pragma mark - UGWaveDirection
typedef NS_ENUM(NSInteger, UGWaveDirection) {
    UGWaveDirectionLeft,    // 波形左移
    UGWaveDirectionRight    // 波形右移
};

@interface UGWaverView : UIView

- (void)start;                      // 开始动画
- (void)stop;                       // 停止动画
- (void)reset;                      // 波形复位
- (void)addWaves:(NSArray*)waves;   // 添加波形线条

@end

#pragma mark - UGWave
@interface UGWave : NSObject

@property (nonatomic, strong) CAShapeLayer *layer;          // 用于绘制波形的Layer
@property (nonatomic, assign) UGWaveStyle style;            // 波形类型：正弦/余弦
@property (nonatomic, assign) UGWaveDirection direction;    // 波形移动的方向
@property (nonatomic, assign) CGFloat width;                // 波形一个周期对应的x轴宽度
@property (nonatomic, assign) CGFloat amplitude;            // 波形振幅
@property (nonatomic, assign) CGFloat lineWidth;            // 波形线条宽度
@property (nonatomic, assign) CGFloat offsetX;              // 波形x轴偏移量
@property (nonatomic, assign) CGFloat stepX;                // 波形移动的步进值（影响波形传播速度）
@property (nonatomic, assign) CGFloat moveX;                // 波形传递时的当前x轴位置

- (instancetype)initWithStyle:(UGWaveStyle)style
                    direction:(UGWaveDirection)direction
                    amplitude:(CGFloat)amplitude
                        width:(CGFloat)width
                    lineWidth:(CGFloat)lineWidth
                      offsetX:(CGFloat)offsetX
                        stepX:(CGFloat)stepX
                 layerCreator:(CALayer* (^)(CAShapeLayer *waveLayer))layerCreator;
- (CALayer*)createLayerWithFrame:(CGRect)frame;
- (void)moveOneStep;
- (void)clearLayer;

@end

#pragma mark - UGWaveWeakProxy(Private)
@interface UGWaveWeakProxy : NSObject

+ (instancetype)proxyWithTarget:(id)target;

@end
NS_ASSUME_NONNULL_END
