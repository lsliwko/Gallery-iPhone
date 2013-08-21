//
//  GUIUtilities.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GUIUtilities.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"

//static NSMutableDictionary* viewsMessageLabelsMap;

@implementation GUIUtilities


//+(NSMutableDictionary*) viewsMessageLabelsMap {
//    return viewsMessageLabelsMap;
//}

+(UIView*) showErrorMessage:(UIViewController*)uiViewController message:(NSString *)message {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    return [GUIUtilities showMessage:uiViewController message:message foregroundColor:[UIColor whiteColor] backgroundColor:[UIColor redColor]];
}

+(UIView*) showMessage:(UIViewController*)uiViewController message:(NSString *)message foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor {
    NSLog(@"Show message %@", message);
    
    __weak UIViewController *weakSelf = uiViewController;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                               10,
                                                               weakSelf.view.frame.size.height/2-25,
                                                               weakSelf.view.frame.size.width-20,
                                                               50)];

    /*
    //remove old message if it exist
    UILabel *oldLabel   = [viewsMessageLabelsMap objectForKey:uiViewController.title];
    if (oldLabel) {
        [oldLabel removeFromSuperview];
    }
    [viewsMessageLabelsMap setObject:label forKey:uiViewController.title];
    */
    
    // Update the UI
    dispatch_async(dispatch_get_main_queue(), ^{
        label.backgroundColor = backgroundColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor=foregroundColor;
        label.text = message;
        label.layer.borderColor = foregroundColor.CGColor;
        label.layer.borderWidth = 2;
        label.layer.cornerRadius = 8;
        
        [weakSelf.view addSubview:label];
        
        [label setAlpha:0.0];
        [UIView animateWithDuration:0.35
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void) {
                             [label setAlpha:0.7];
                         }
                         completion:^(BOOL finished) {
                             if(finished) {
                                 [UIView animateWithDuration:0.15
                                                       delay:2.5
                                                     options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                                  animations:^(void) {
                                                      [label setAlpha:0.0];
                                                  }
                                                  completion:^(BOOL finished) {
                                                      if(finished) {
                                                          NSLog(@"Message fadedIn & fadedOut");
                                                          [label removeFromSuperview];
                                                      }
                                                  }];
                             }
                         }];
        
    });
    
    return label;
}

+(void) loadImageViewAsync:(UIViewController*)uiViewController uiImageView:(UIImageView*)uiImageView imageUrl:(NSString *)imageUrl placeholderImage:(UIImage*)placeholderImage {
    // load asynchroniciously with SDWebImage
    [uiImageView setImageWithURL:[NSURL URLWithString:imageUrl]
          placeholderImage:placeholderImage
                   options:SDWebImageProgressiveDownload
                  progress:^(NSUInteger receivedSize, long long expectedSize) {
                      // progression tracking code
                      NSLog(@"Loading image [%@] %i/%lli", imageUrl, receivedSize, expectedSize);
                  }
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                     // completion tracking code
                     
                     if (error) {
                         [GUIUtilities showErrorMessage:uiViewController message:@"Connection error"];
                     } else {
                         NSLog(@"Image [%@] loaded", imageUrl);
                     }
                 }
    ];
}


@end
