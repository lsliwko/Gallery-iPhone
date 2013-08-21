//
//  GalleryArtistDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 20/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryArtistDetailViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
