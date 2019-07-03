//
//  MapView.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import "MapView.h"

@interface MapView()



@end

@implementation MapView

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
    if (_viewForAnnotation) {
        return _viewForAnnotation(mapView,annotation);
    }
    return nil;
    
}

-(void)layoutSubviews{
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
