//
//  GalleryContactViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 18/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import "GalleryAboutViewController.h"
#import "GallerySettingsManager.h"

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

    
    NSString *filePath = [[GallerySettingsManager sharedManager] aboutPageFilePath];
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    if (htmlData) {
        [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:nil]];
    }
    
    self.title  = @"About";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
