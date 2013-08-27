//
//  GalleryExhibitionDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryExhibitionDetailViewController.h"
#import "GUIUtilities.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface GalleryExhibitionDetailViewController ()

@end

@implementation GalleryExhibitionDetailViewController

@synthesize exhibitionObject = _exhibitionObject;

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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"arrow-simple-01-white.png"]
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"arrow-box-out-right-mini-white.png"]
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title  = self.exhibitionObject.title;
    
    [self.titleLabel setText:self.exhibitionObject.title];
    [self.descriptionLabel setText:self.exhibitionObject.description];
    
    [GUIUtilities loadImageViewAsync:self
                         uiImageView:self.imageView
                            imageUrl:self.exhibitionObject.imageUrl
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         forceResize:NO
    ];
    
    if (self.exhibitionObject.catalogueUrl) {
        self.catalogueButton.hidden = NO;
    } else {
        self.catalogueButton.hidden = YES;
    }
}

- (void)backAction
{
    NSLog(@"actionBack");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareAction
{
    NSLog(@"shareAction");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Share via"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
    
    [actionSheet showFromTabBar:[[self tabBarController] tabBar]];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet button index=%i", buttonIndex);
    
    NSString *serviceType;
    switch (buttonIndex)
    {
        case 0:
            serviceType =   SLServiceTypeFacebook;
            break;
        case 1:
            serviceType =   SLServiceTypeTwitter;
            break;
        case 2:
            serviceType =   @"Email";
            break;
        default:
            return;
    }
    
    if ([serviceType isEqualToString:@"Email"]) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
            
            emailController.mailComposeDelegate = self;
            
            [emailController setSubject:self.exhibitionObject.title];
            
            NSMutableString *htmlMsg = [NSMutableString string];
            [htmlMsg appendString:@"<html><body>"];
            
            if ((self.exhibitionObject.imageUrl)&&(self.imageView.image)) {
                NSData *jpegData = UIImageJPEGRepresentation(self.imageView.image, 1);
                
                NSString *fileName = @"photo";
                fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
                [emailController addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            }
            
            if (self.exhibitionObject.pageUrl) {
                [htmlMsg appendString:@"<p>"];
                [htmlMsg appendString:self.exhibitionObject.pageUrl];
                [htmlMsg appendString:@"</p>"];
            }
            [htmlMsg appendString:@"</body></html>"];
            
            [emailController setMessageBody:htmlMsg isHTML:YES];
            
            [self presentViewController:emailController animated:YES completion:nil];
        }
        // Show error if no mail account is active
        else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You must have a mail account in order to send an email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        if ([SLComposeViewController isAvailableForServiceType:serviceType])
        {
            SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:serviceType];
            
            NSString *textToShare = self.exhibitionObject.title;
            
            [composeViewController setInitialText:textToShare];
            
            //check if there is image and if image has been loaded
            if ((self.exhibitionObject.imageUrl)&&(self.imageView.image)) {
                [composeViewController addImage:self.imageView.image];
            }
            
            if (self.exhibitionObject.pageUrl) {
                [composeViewController addURL:[NSURL URLWithString:self.exhibitionObject.pageUrl]];
            }
            
            [self presentViewController:composeViewController animated:YES completion:nil];
            
        }
        else{
            
            NSString* alertString = @"Please add a Twitter/Facebook account for the network you plan to share to. You can do this in the Settings app";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add account" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }
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

- (IBAction)catalogueAction:(id)sender {
    NSLog(@"catalogueAction");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.exhibitionObject.catalogueUrl]];
}

- (IBAction)openPageAction:(id)sender {
    NSLog(@"openPageAction");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.exhibitionObject.pageUrl]];
}
@end
