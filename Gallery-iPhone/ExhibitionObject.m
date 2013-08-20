//
//  ExhibitionObject.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "ExhibitionObject.h"

@implementation ExhibitionObject

@synthesize title = _title;
@synthesize description = _description;
@synthesize imageUrl = _imageUrl;
@synthesize pageUrl = _pageUrl;
@synthesize catalogueUrl = _catalogueUrl;

- (id)initWithTitle:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageUrl pageUrl:(NSString*)pageUrl catalogueUrl:(NSString*)catalogueUrl {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.imageUrl   = imageUrl;
        self.pageUrl   = pageUrl;
        self.catalogueUrl   = catalogueUrl;
    }
    return self;
}

@end
