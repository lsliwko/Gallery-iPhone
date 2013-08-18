//
//  GalleryAboutViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface GalleryAboutViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)contactAction:(id)sender;
- (IBAction)openPageAction:(id)sender;

@end
