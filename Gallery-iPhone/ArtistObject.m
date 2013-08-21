//
//  ArtistObject.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 20/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "ArtistObject.h"

@implementation ArtistObject

@synthesize name = _name;
@synthesize description = _description;
@synthesize imageUrls = _imageUrls;

- (id)initWithName:(NSString*)name description:(NSString*)description imageUrls:(NSMutableArray*)imageUrls {
    if ((self = [super init])) {
        self.name = name;
        self.description = description;
        self.imageUrls   = imageUrls;
    }
    return self;
}
@end
