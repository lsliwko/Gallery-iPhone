//
//  GallerySettingsManager.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 18/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GallerySettingsManager.h"
#import <MapKit/MapKit.h>
#import "ExhibitionObject.h";

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

- (NSMutableArray *)loadExhibitions:(NSError**) error {
    NSLog(@"loadExhibitions");
    
    NSString *url   = @"http://www.hua-gallery.com/exhibition_data.xml";
    NSData* data = [NSData
                    dataWithContentsOfURL:[NSURL URLWithString:url]
                    options:NSDataReadingUncached
                    error:error];
    
    if (*error) {
        NSLog(@"Could not load data from [%@] Error [%@]", url, [*error localizedDescription]);
        return nil;
    } else {
        NSLog(@"Loaded %i bytes from [%@]", data.length, url);
    }
    
    ExhibitionObject *test1 = [[ExhibitionObject alloc] initWithTitle:@"title1" description:@"description1" imageUrl:@"http://www.hua-gallery.com/images/exhibition/imgb14s.jpg"];
    ExhibitionObject *test2 = [[ExhibitionObject alloc] initWithTitle:@"title2" description:@"description2" imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_19_sq.jpg"];
    ExhibitionObject *test3 = [[ExhibitionObject alloc] initWithTitle:@"title3" description:@"description3" imageUrl:@"http://www.hua-gallery.com/images/exhibition/imgb14s.jpg"];
    
    return [NSMutableArray arrayWithObjects:test1, test2, test3, nil];
}

@end