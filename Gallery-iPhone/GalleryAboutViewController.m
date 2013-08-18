//
//  GalleryAboutViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryAboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GUIUtilities.h"

@interface GalleryAboutViewController ()

@end

@implementation GalleryAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Map"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(mapAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title  = @"About";
}

- (void)mapAction
{
    //TODO implement
    NSLog(@"mapAction");
    [self performSegueWithIdentifier:@"mapViewSegueId" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactAction:(id)sender {
    /*
    NSLog(@"contactAction");
    
    // create mail subject
    NSString *subject = [NSString stringWithFormat:@""];
    
    // define email address
    NSString *mail = [NSString stringWithFormat:@"info@hua-gallery.com"];
    
    // create the URL
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"mailto:?to=%@&subject=%@",
                                                [mail stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                                [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    
    // load the URL
    [[UIApplication sharedApplication] openURL:url];
    */
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
        emailController.mailComposeDelegate = self;
        
        [emailController setSubject:@""];
        [emailController setMessageBody:@"" isHTML:YES];
        [emailController setToRecipients:[NSArray arrayWithObjects:@"info@hua-gallery.com", nil]];

        [self presentViewController:emailController animated:YES completion:nil];
    }
    // Show error if no mail account is active
    else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You must have a mail account in order to send an email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (result == MFMailComposeResultFailed) {
        [GUIUtilities showErrorMessage:self message:@"Failed sending mail"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}

- (IBAction)openPageAction:(id)sender {
    NSLog(@"openPageAction");
}
@end
