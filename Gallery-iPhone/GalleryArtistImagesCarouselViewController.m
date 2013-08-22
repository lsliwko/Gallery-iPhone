//
//  GalleryArtistImagesCarouselViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 21/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryArtistImagesCarouselViewController.h"
#import "GUIUtilities.h"
#import "UIImageView+WebCache.h"

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
    
    self.title  = self.artistObject.name;
    
    self.carouselView.type = iCarouselTypeLinear;

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

- (void)viewDidUnload {
    [self setCarouselView:nil];
    [super viewDidUnload];
}


#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSLog(@"Number of iitems %i", [self.artistObject.imageUrls count]);
    return [self.artistObject.imageUrls count];
}


- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return 1;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view {
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        UIImageView *imageView   = [[UIImageView alloc] initWithFrame:CGRectMake(
                   self.carouselView.frame.origin.x,
                   self.carouselView.frame.origin.y,
                   self.carouselView.frame.size.height,
                   self.carouselView.frame.size.width
        )];
        
        [GUIUtilities loadImageViewAsync:self
                             uiImageView:imageView
                                imageUrl:[self.artistObject.imageUrls objectAtIndex:index]
                        placeholderImage:[UIImage imageNamed:@"placeholder"]
                             forceResize:YES
        ];
        
        view    = imageView;
        
        view.contentMode = UIViewContentModeCenter;
    }
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 320+2;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return NO;
}

@end
