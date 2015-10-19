//
//  ViewController.m
//  MapAPi
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface ViewController ()<MAMapViewDelegate>
{
    CLLocationCoordinate2D *_coordinates;
    MAMapView *mapView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   
}
- (IBAction)SearchMypointBtu:(id)sender
{
        [self Maptest];
}


- (void)Maptest
{
   mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    // mapView.mapType = MAMapTypeSatellite;
    mapView.showTraffic = YES;
    mapView.delegate = self;
   // mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [mapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading];
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    //  设置跟随模式
    [mapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading animated:YES];
    mapView.pausesLocationUpdatesAutomatically = NO;
}


#pragma mark// get User's Location
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {
        NSLog(@"lat:%f,lon:%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
   
    [self addAnnotation:userLocation.coordinate];

}

#pragma mark//   为路线做标注
//   为路线加标注
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:@"point"];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc]
                              initWithAnnotation:annotation reuseIdentifier:@"point"];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
}
    return nil;
}

- (void)addAnnotation:(CLLocationCoordinate2D)location {
    MAPointAnnotation *annotation = [[MAPointAnnotation
                                      alloc] init];
        annotation.coordinate = location;
        annotation.title = @"你在这";
        annotation.subtitle = @"Hello";
        [mapView addAnnotation:annotation];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
