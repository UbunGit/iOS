//
//  BlockMAMapView.h
//  UGOCMagicbox
//
//  Created by admin on 2019/7/2.
//  Copyright © 2019 UG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockMAMapView : UIView

@property(strong, nonnull) MAMapView *mapView;

@property(copy, nonatomic) MAAnnotationView* (^ug_viewForAnnotation)(MAMapView* mapView,id <MAAnnotation> annotation);

@property(copy, nonatomic) MAOverlayRenderer* (^ug_rendererForOverlay)(MAMapView* mapView,id <MAOverlay> overlay);

@end

NS_ASSUME_NONNULL_END
