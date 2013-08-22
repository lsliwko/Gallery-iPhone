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

//+(NSMutableDictionary*)viewsMessageLabelsMap;

+(UIView*) showMessage:(UIViewController*)uiViewController message:(NSString *)message foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor;

+(UIView*) showErrorMessage:(UIViewController*)uiViewController message:(NSString *)message;

+(void) loadImageViewAsync:(UIViewController*)uiViewController uiImageView:(UIImageView*)uiImageView imageUrl:(NSString *)imageUrl placeholderImage:(UIImage*)placeholderImage forceResize:(Boolean *)forceResize;

@end
