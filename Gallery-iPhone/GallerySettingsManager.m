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
#import "ArtistObject.h";

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
    
    ExhibitionObject *test1 = [[ExhibitionObject alloc] initWithTitle:@"Between Spiritual and Material Spaces: the Photographic World of the Gao Brothers" description:@"Hua Gallery is honoured to announce the exhibition of internationally recognised Chinese artists the Gao Brothers." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img14s2.jpg" pageUrl:@"http://www.hua-gallery.com/exhibition_details_14.html" catalogueUrl:@"http://www.hua-gallery.com/pdf/catalogue/gao_brothers.pdf"];
    ExhibitionObject *test2 = [[ExhibitionObject alloc] initWithTitle:@"Sheng Qi: a New Wind of Economics" description:@"Hua Gallery is delighted to host the exhibition of firmly established artist Sheng Qi at Playboy Club in Mayfair." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_19_sq_s2.jpg" pageUrl:@"http://www.hua-gallery.com/exhibition_details_19.html" catalogueUrl:nil];
    ExhibitionObject *test3 = [[ExhibitionObject alloc] initWithTitle:@"Nothing is Still Sheng Qi’s Political Symbolism and Le Guo’s Abstract Journey" description:@"Hua Gallery is pleased to announce a partnership with Aria Art Gallery in Florence where we will host a show of Le Guo and Sheng Qi, introducing their striking art to a new audience." imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_20_ls_s2.jpg" pageUrl:@"http://www.hua-gallery.com/exhibition_details_20.html" catalogueUrl:nil];
    
    return [NSMutableArray arrayWithObjects:test1, test2, test3, nil];
}

- (NSMutableArray *)loadArtists:(NSError**) error {
    NSLog(@"loadArtists");
    
    ArtistObject *test1 = [[ArtistObject alloc] initWithName:@"Art toys" description:@"Art Toys is a collaborative work incorporating art, design, and fashion created by Yue Minjun & KAWS, Zhou Chunya, Zhou Tiehai, Liu Ye, and Jin Nu." imageUrls:[NSMutableArray arrayWithObjects:@"http://www.hua-gallery.com/images/arttoys/YueMinjun.jpg", @"http://www.hua-gallery.com/images/arttoys/ZhouChunya.jpg", @"http://www.hua-gallery.com/images/arttoys/LiuYe.jpg", @"http://www.hua-gallery.com/images/arttoys/ZhouTiehai.jpg", nil]];
    ArtistObject *test2 = [[ArtistObject alloc] initWithName:@"Beili Liu" description:@" Beili Liu is a contemporary Chinese-American artist, who creates atmospheric large-scale installation works and two-dimensional works. Her works explore and respond to the poetic possibilities of quotidian materials; the pieces look at transformation, time lapse and fragility and speak of complex and delicate human connections." imageUrls:[NSMutableArray arrayWithObjects:@"http://www.hua-gallery.com/images/beililiu/1.jpg", @"http://www.hua-gallery.com/images/beililiu/2.jpg", @"http://www.hua-gallery.com/images/beililiu/3.jpg", nil]];
                           
    return [NSMutableArray arrayWithObjects:test1, test2, nil];
}

@end