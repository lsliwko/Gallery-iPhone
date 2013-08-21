//
//  ArtistObject.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 20/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistObject : NSObject

@property (strong) NSString *name;
@property (strong) NSString *description;

@property (strong) NSMutableArray *imageUrls;

- (id)initWithName:(NSString*)name description:(NSString*)description imageUrls:(NSMutableArray*)imageUrls;

@end
