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
#import "LocView.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self reloaddata];
}
//从数据库获取已有用户数据
-(void)reloaddata{
    RLMResults *resArr = [Userinfo allObjects];
    for (Userinfo* userinfo in resArr) {
        [self mapaddAnnotationUserinfo:userinfo];
    }
}
//设置UI
-(void)configUI{
    self.mapview = [BlockMAMapView new];
    [self.view addSubview:_mapview];
    __weak __typeof(self) weakself = self;
    //添加标记
    _mapview.ug_viewForAnnotation = ^MAAnnotationView * _Nonnull(MAMapView * _Nonnull mapView, id<MAAnnotation>  _Nonnull annotation) {
        if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
            static NSString *reuseIndetifier = @"LocView";
            LocView *annotationView = (LocView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[LocView alloc] initWithAnnotation:annotation
                                                     reuseIdentifier:reuseIndetifier];
            }
            UIImage *temimage = [UIImage imageWithIcon:@"fa-map-marker" backgroundColor:[UIColor clearColor] iconColor:UIColor.ug_random andSize:CGSizeMake(50, 50)];
            annotationView.imageView.image = temimage;
            annotationView.titleLab.text = annotation.title;
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, 0);
            [annotationView.clickbtn ug_addEvents:UIControlEventTouchUpInside andBlock:^(id  _Nonnull sender) {
                //点击取消标记
                Userinfo *userinfo = [Userinfo objectsWhere:[NSString stringWithFormat:@"name = '%@'",annotation.title]].firstObject;
                if(!userinfo){
                    return;
                }
                RLMRealm *realm = [RLMRealm defaultRealm];
                // 删除单条记录
                [realm transactionWithBlock:^{
                    [realm deleteObject:userinfo];
                    [weakself.mapview.mapView removeAnnotations:@[annotation]];
                }];
            }];
            return annotationView;
        }
       
        return nil;
    };
    //添加圆
    _mapview.ug_rendererForOverlay = ^MAOverlayRenderer * _Nonnull(MAMapView * _Nonnull mapView, id<MAOverlay>  _Nonnull overlay) {
        if ([overlay isKindOfClass:[MACircle class]])
        {
            MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
            
            circleRenderer.lineWidth    = 5.f;
            circleRenderer.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
            circleRenderer.fillColor    = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
            return circleRenderer;
        }
         return nil;
    };
    
    //点击手势
    [_mapview.mapView addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        CGPoint touchPoint = [sender locationInView:self.mapview.mapView];
        CLLocationCoordinate2D touchMapCoordinate =
        [self.mapview.mapView convertPoint:touchPoint toCoordinateFromView:self.mapview.mapView];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            //添加一个用户
            Userinfo *userinfo = [Userinfo new];
            userinfo.name =[NSString stringWithFormat:@"%ld",random()%255];
            userinfo.headimage =[NSString stringWithFormat:@"%ld",random()%255];
            userinfo.latitude =touchMapCoordinate.latitude;
            userinfo.longitude =touchMapCoordinate.longitude;
            [realm addObject:userinfo];
            [self mapaddAnnotationUserinfo:userinfo];
        }];
        [self.view alert:[NSString stringWithFormat:@"经%f 维%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude]];
    }]];
    //长按手势
    __block CGPoint beginpoint;
    [self.mapview.mapView addGestureRecognizer:[UILongPressGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        if (state == UIGestureRecognizerStateBegan) {//注1
            //删除已有的圆
            [self.mapview.mapView removeOverlays:self.mapview.mapView.overlays];
            beginpoint = location;
        }
        if (state == UIGestureRecognizerStateEnded) {//注1
            //添加一个圆
            CGPoint endpoint = location;
            CLLocationCoordinate2D begindinate =
            [self.mapview.mapView convertPoint:beginpoint toCoordinateFromView:self.mapview.mapView];
            CLLocationCoordinate2D enddinate =
            [self.mapview.mapView convertPoint:endpoint toCoordinateFromView:self.mapview.mapView];
            
            MAMapPoint point1 = MAMapPointForCoordinate(begindinate);
            MAMapPoint point2 = MAMapPointForCoordinate(enddinate);
            
            CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
            MACircle *circle = [MACircle circleWithCenterCoordinate:begindinate radius:distance];
            
            //在地图上添加圆
            [self.mapview.mapView addOverlay: circle];
            [self.view alert:[NSString stringWithFormat:@"%f",distance]];
        }
    }]];

}

//添加标记
-(void)mapaddAnnotationUserinfo:(Userinfo*)userinfo{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(userinfo.latitude, userinfo.longitude);
    pointAnnotation.title = userinfo.name;
    pointAnnotation.subtitle = userinfo.headimage;
    [_mapview.mapView addAnnotation:pointAnnotation];
    DDLogVerbose(@"annotations %zd",_mapview.mapView.annotations.count);
}

-(void)viewLayoutMarginsDidChange{
    [super viewLayoutMarginsDidChange];
    [_mapview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end
