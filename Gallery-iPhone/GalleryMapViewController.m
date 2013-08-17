//
//  GalleryMapViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryMapViewController.h"
#import <MapKit/MapKit.h>

@interface GalleryMapViewController () {

    @private
    MKPointAnnotation *point;

}
@end

#define METERS_PER_MILE 1609.344

@implementation GalleryMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Reset"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(resetAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title  = @"Map";
    
    CLLocationCoordinate2D location;
    location.latitude = 51.480153;
    location.longitude= -0.169966;
    
    // Add the annotation to our map view
    point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = @"H U A";
    point.subtitle = @"Gallery";
    
    [self.mapView addAnnotation:point];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Refreshing view...");
    
    //map view needs to have frame adjusted, otherwise location cannot be set properly
    _mapView.frame = self.view.bounds;
    _mapView.autoresizingMask = self.view.autoresizingMask;
    
    [self centerOnLocation];
}

- (void)resetAction
{
    NSLog(@"resetAction");
    [self centerOnLocation];
}

-(void) centerOnLocation {
    NSLog(@"centerOnLocation");
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(point.coordinate,0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
    NSLog(@"Location set to %f, %f, %f, %f",
          _mapView.region.center.latitude,
          _mapView.region.center.longitude,
          _mapView.region.span.latitudeDelta,
          _mapView.region.span.longitudeDelta);
    
    //open immediately
    [self.mapView selectAnnotation:point animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
