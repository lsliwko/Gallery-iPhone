//
//  GallerySettingsManager.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 18/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GallerySettingsManager : NSObject {
    NSString *email;
    NSString *homepageUrl;
    
    CLLocationCoordinate2D locationCoordinates;
    NSString *locationTitle;
    NSString *locationSubtitle;
    
    NSString *aboutPageFilePath;
    NSString *contactPageFilePath;
}

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *homepageUrl;

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinates;
@property (nonatomic, retain) NSString *locationTitle;
@property (nonatomic, retain) NSString *locationSubtitle;

@property (nonatomic, retain) NSString *aboutPageFilePath;
@property (nonatomic, retain) NSString *contactPageFilePath;
@property (nonatomic, retain) NSMutableArray *exhibitions;

+ (id)sharedManager;

- (NSMutableArray *)loadExhibitions:(NSError**) error;
- (NSMutableArray *)loadArtists:(NSError**) error;

@end

