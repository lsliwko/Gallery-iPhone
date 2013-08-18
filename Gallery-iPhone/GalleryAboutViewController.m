//
//  GalleryAboutViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 17/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryAboutViewController.h"

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
    NSLog(@"contactAction");
}

- (IBAction)openPageAction:(id)sender {
    NSLog(@"openPageAction");
}
@end
