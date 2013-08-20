//
//  GalleryAboutViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryContactViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GUIUtilities.h"
#import "GallerySettingsManager.h"

@interface GalleryContactViewController ()

@end

@implementation GalleryContactViewController

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
                                  initWithImage:[UIImage imageNamed:@"brochure-mini-white.png"]
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(mapAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *filePath = [[GallerySettingsManager sharedManager] contactPageFilePath];
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    if (htmlData) {
        [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    }
    
    self.title  = @"Contact";
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
    NSString *email = [[GallerySettingsManager sharedManager] email];
    
    /*
    NSLog(@"contactAction");
    
    // create mail subject
    NSString *subject = [NSString stringWithFormat:@""];
    
    // define email address
    NSString *mail = [NSString stringWithFormat:email];
    
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
        [emailController setToRecipients:[NSArray arrayWithObjects:email, nil]];

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
    
    NSString *homepageUrl   = [[GallerySettingsManager sharedManager] homepageUrl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:homepageUrl]];
}

@end
