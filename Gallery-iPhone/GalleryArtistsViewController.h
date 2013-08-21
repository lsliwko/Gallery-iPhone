//
//  GalleryArtistsViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryArtistsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong) NSMutableArray *artists;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
