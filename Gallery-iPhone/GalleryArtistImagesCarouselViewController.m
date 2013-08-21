//
//  GalleryArtistImagesCarouselViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 21/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryArtistImagesCarouselViewController.h"

@interface GalleryArtistImagesCarouselViewController ()

@end

@implementation GalleryArtistImagesCarouselViewController

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

@end
