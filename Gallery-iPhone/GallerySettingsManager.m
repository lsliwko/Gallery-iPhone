//
//  GallerySettingsManager.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 18/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GallerySettingsManager.h"
#import <MapKit/MapKit.h>

@implementation GallerySettingsManager

@synthesize email;
@synthesize homepageUrl;

@synthesize locationCoordinates;
@synthesize locationTitle;
@synthesize locationSubtitle;

@synthesize aboutPageFilePath;
@synthesize contactPageFilePath;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static GallerySettingsManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        // provide all settings and other methods there
        email = @"info@hua-gallery.com";
        homepageUrl = @"http://www.hua-gallery.com";
        
        //location data
        locationCoordinates.latitude = 51.480153;
        locationCoordinates.longitude= -0.169966;
        locationTitle   = @"H U A";
        locationSubtitle    = @"Gallery";
        
        aboutPageFilePath   = [[NSBundle mainBundle] pathForResource:@"HUAGallery-About" ofType:@"html"];
        contactPageFilePath   = [[NSBundle mainBundle] pathForResource:@"HUAGallery-Contact" ofType:@"html"];
    }
    return self;
}

@end