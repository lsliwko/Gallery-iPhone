//
//  GalleryExhibitionDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryExhibitionDetailViewController.h"

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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Share"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title  = self.exhibitionObject.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareAction
{
    //TODO implement
    NSLog(@"shareAction");
}

- (IBAction)openPageAction:(id)sender {
    NSLog(@"openPageAction");
}

- (IBAction)catalogueAction:(id)sender {
    NSLog(@"catalogueAction");
}
@end
