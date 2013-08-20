//
//  GalleryExhibitionDetailViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionObject.h"


@interface GalleryExhibitionDetailViewController : UIViewController

@property (strong) ExhibitionObject *exhibitionObject;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *catalogueButton;

- (IBAction)openPageAction:(id)sender;
- (IBAction)catalogueAction:(id)sender;
@end
