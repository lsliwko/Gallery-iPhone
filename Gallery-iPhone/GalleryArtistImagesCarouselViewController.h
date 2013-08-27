//
//  GalleryArtistImagesCarouselViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 21/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistObject.h"
#import "iCarousel.h"
#import "UIImageView+WebCache.h"

@interface GalleryArtistImagesCarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, SDWebImageManagerDelegate>

@property (strong) ArtistObject *artistObject;

@property (weak, nonatomic) IBOutlet UIImageView *swipeGestureImageView;

@property (weak, nonatomic) IBOutlet iCarousel *carouselView;
@end
