//
//  GalleryArtistDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 20/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryArtistDetailViewController.h"
#import "GalleryArtistImagesCarouselViewController.h"

@interface GalleryArtistDetailViewController ()

@end

@implementation GalleryArtistDetailViewController

@synthesize artistObject = _artistObject;

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
                                  initWithImage:[UIImage imageNamed:@"screen-anchor-point-mini-white.png"]
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(imageGalleryAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString* webContent = [NSString stringWithFormat:@"<html>\n"
                            "<head>\n"
                            "</head>\n"
                            "<body>"
                            "<div id='wrapper' style='width:100%%; text-align:center'>"
                            "<img src='hua-logo2.jpg'>"
                            "</div>"
                            "<p class='title' align='center'><b>%@</b></p>"
                            "<p align='justify'>%@</p>"
                            "<div id='wrapper' style='width:100%%; text-align:center'>"
                            "<img src='hua-logo2.jpg'>"
                            "</div>"
                            "</body>"
                            "</html>",
                            self.artistObject.name,
                            self.artistObject.description
                            ];

    [self.webView loadHTMLString:webContent baseURL:baseURL];
    
    //NSString *filePath = [[GallerySettingsManager sharedManager] aboutPageFilePath];
    //NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    //if (htmlData) {
    //    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    //}
    
    self.title  = self.artistObject.name;
}

- (void)backAction
{
    NSLog(@"actionBack");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageGalleryAction
{
    NSLog(@"imageGalleryAction");
    [self performSegueWithIdentifier:@"artistImagesCarouselViewSegueId" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"artistImagesCarouselViewSegueId"])
    {
        GalleryArtistImagesCarouselViewController *viewController = [segue destinationViewController];
        viewController.artistObject = self.artistObject;
    }
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
