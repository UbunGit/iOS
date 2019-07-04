//
//  BlockMAMapView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import "BlockMAMapView.h"

@interface BlockMAMapView()<MAMapViewDelegate>

@end

@implementation BlockMAMapView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.mapView = [MAMapView new];
    _mapView.delegate = self;
    [self addSubview:_mapView];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if (_ug_viewForAnnotation) {
        return _ug_viewForAnnotation(mapView,annotation);
    }
    return nil;
    
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if (_ug_rendererForOverlay) {
        return _ug_rendererForOverlay(mapView, overlay);
    }
    return nil;
}

-(void)layoutSubviews{
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
