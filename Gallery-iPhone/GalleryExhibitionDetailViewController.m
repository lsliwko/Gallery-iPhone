//
//  GalleryExhibitionDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryExhibitionDetailViewController.h"
#import "GUIUtilities.h"
#import "SHK.h"

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

    // Create the item to share (in this example, a url)
	NSURL *url = [NSURL URLWithString:self.exhibitionObject.pageUrl];
	SHKItem *item = [SHKItem URL:url title:@"Shared from gallery"];
    
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
	// Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];

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
