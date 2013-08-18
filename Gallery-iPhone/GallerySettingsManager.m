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
        locationTitle   = @"HUA Gallery";
        locationSubtitle    = @"Unit 7B, Albion Riverside, 8 Hester Road";
        
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
    
    ExhibitionObject *test1 = [[ExhibitionObject alloc] initWithTitle:@"Between Spiritual and Material Spaces: the Photographic World of the Gao Brothers" description:@"Hua Gallery is honoured to announce the exhibition of internationally recognised Chinese artists the Gao Brothers." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img14s2.jpg"];
    ExhibitionObject *test2 = [[ExhibitionObject alloc] initWithTitle:@"Sheng Qi: a New Wind of Economics" description:@"Hua Gallery is delighted to host the exhibition of firmly established artist Sheng Qi at Playboy Club in Mayfair." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_19_sq_s2.jpg"];
    ExhibitionObject *test3 = [[ExhibitionObject alloc] initWithTitle:@"Nothing is Still Sheng Qi’s Political Symbolism and Le Guo’s Abstract Journey" description:@"Hua Gallery is pleased to announce a partnership with Aria Art Gallery in Florence where we will host a show of Le Guo and Sheng Qi, introducing their striking art to a new audience." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_20_ls_s2.jpg"];
    
    return [NSMutableArray arrayWithObjects:test1, test2, test3, nil];
}

@end