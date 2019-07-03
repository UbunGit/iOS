//
//  MapViewController.m
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import "MapViewController.h"
#import "Userinfo.h"
#import "UIGestureRecognizer+BlocksKit.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.mapview = [MapView new];
    [self.view addSubview:_mapview];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapview.mapView addAnnotation:pointAnnotation];
    
    _mapview.viewForAnnotation = ^MAAnnotationView * _Nonnull(MAMapView * _Nonnull mapView, id<MAAnnotation>  _Nonnull annotation) {
        if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            }
            UIImage *temimage = [UIImage imageWithIcon:@"fa-map-marker" backgroundColor:[UIColor clearColor] iconColor:UIColor.ug_random andSize:CGSizeMake(20, 20)];
            annotationView.image = temimage;
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            return annotationView;
        }
        return nil;
    };
    
   
    [_mapview.mapView addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        CGPoint touchPoint = [sender locationInView:self.mapview.mapView];
        CLLocationCoordinate2D touchMapCoordinate =
        [self.mapview.mapView convertPoint:touchPoint toCoordinateFromView:self.mapview.mapView];
        [self.view alert:[NSString stringWithFormat:@"经%f 维%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude]];
    }]];
    
//    [_mapview.mapView ]
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_mapview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
