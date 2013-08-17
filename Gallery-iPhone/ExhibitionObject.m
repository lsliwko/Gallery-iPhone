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

- (id)initWithTitle:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageUrl {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.imageUrl   = imageUrl;
    }
    return self;
}

@end
