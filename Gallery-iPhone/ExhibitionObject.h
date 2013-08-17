//
//  ExhibitionObject.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitionObject : NSObject

@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSString *imageUrl;
@property (strong) UIImage *image;

- (id)initWithTitle:(NSString*)title description:(NSString*)description imageUrl:(NSString*)imageUrl;

@end
