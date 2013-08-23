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
@end
