//
//  GUIUtilities.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GUIUtilities : NSObject

+(void) showMessage:(UIViewController*)uiViewController message:(NSString *)message foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor;

+(void) showErrorMessage:(UIViewController*)uiViewController message:(NSString *)message;

+(void) loadImageViewAsync:(UIViewController*)uiViewController uiImageView:(UIImageView*)uiImageView imageUrl:(NSString *)imageUrl placeholderImage:(UIImage*)placeholderImage;

@end
