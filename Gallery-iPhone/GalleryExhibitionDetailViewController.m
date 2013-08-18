//
//  GalleryExhibitionDetailViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryExhibitionDetailViewController.h"
#import "GUIUtilities.h"

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
    
    [self.titleLabel setText:self.exhibitionObject.title];
    [self.descriptionLabel setText:self.exhibitionObject.description];
    
    [GUIUtilities loadImageViewAsync:self
                         uiImageView:self.imageView
                            imageUrl:self.exhibitionObject.imageUrl
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]
    ];
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

- (IBAction)catalogueAction:(id)sender {
    NSLog(@"catalogueAction");
}

- (IBAction)openPageAction:(id)sender {
    NSLog(@"openPageAction");
}
@end
