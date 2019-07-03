//
//  MapView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapView : UIView<MAMapViewDelegate>

@property(strong, nonnull) MAMapView *mapView;

@property(copy, nonatomic) MAAnnotationView* (^viewForAnnotation)(MAMapView* mapView,id <MAAnnotation> annotation);
@end

NS_ASSUME_NONNULL_END
