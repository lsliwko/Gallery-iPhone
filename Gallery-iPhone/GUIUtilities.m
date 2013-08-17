//
//  GUIUtilities.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GUIUtilities.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GUIUtilities

+(void) showErrorMessage:(UIViewController*)uiViewController message:(NSString *)message {
    [GUIUtilities showMessage:uiViewController message:message foregroundColor:[UIColor whiteColor] backgroundColor:[UIColor redColor]];
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

+(void) showMessage:(UIViewController*)uiViewController message:(NSString *)message foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor {
    NSLog(@"Show message %@", message);
    
    __weak UIViewController *weakSelf = uiViewController;
    // Update the UI
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                   10,
                                                                   weakSelf.view.frame.size.height/2-25,
                                                                   weakSelf.view.frame.size.width-20,
                                                                   50)];
        label.backgroundColor = backgroundColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor=foregroundColor;
        label.text = message;
        label.layer.borderColor = foregroundColor.CGColor;
        label.layer.borderWidth = 2;
        label.layer.cornerRadius = 8;
        
        [weakSelf.view addSubview:label];
        
        [label setAlpha:0.0];
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void) {
                             [label setAlpha:0.8];
                         }
                         completion:^(BOOL finished) {
                             if(finished) {
                                 [UIView animateWithDuration:0.25
                                                       delay:2.5
                                                     options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                                  animations:^(void) {
                                                      [label setAlpha:0.0];
                                                  }
                                                  completion:^(BOOL finished) {
                                                      if(finished)
                                                          NSLog(@"Message fadedIn & fadedOut");
                                                  }];
                             }
                         }];
        
    });
}

@end
