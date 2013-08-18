//
//  GalleryMapViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryMapViewController.h"
#import <MapKit/MapKit.h>
#import "GallerySettingsManager.h"


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
    
    CLLocationCoordinate2D location = [[GallerySettingsManager sharedManager] locationCoordinates];
    
    // Add the annotation to our map view
    point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = [[GallerySettingsManager sharedManager] locationTitle];
    point.subtitle = [[GallerySettingsManager sharedManager] locationSubtitle];
    
    [self.mapView addAnnotation:point];
}

-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"Custom annotation");
    
    // If you are showing the users location on the map you don't want to change it
    MKAnnotationView *view = nil;
    if (annotation != mapView.userLocation) {
        // This is not the users location indicator (the blue dot)
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotationIdentifier"];
        if (!view) {
            // Could not reuse a view ...
            
            // Creating a new annotation view, in this case it still looks like a pin
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotationIdentifier"];
            //view.canShowCallOut = YES; // So that the callout can appear
            
            UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"someName"]];
            myImageView.frame = CGRectMake(0,0,31,31); // Change the size of the image to fit the callout
            
            // Change this to rightCallout... to move the image to the right side
            view.leftCalloutAccessoryView = myImageView;
            //[myImageView release], myImageView = nil;
        }
    }
    return view;
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
