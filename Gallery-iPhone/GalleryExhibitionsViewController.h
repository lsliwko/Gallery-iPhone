//
//  GalleryExhibitionsViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryExhibitionsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *exhibitionsTableView;
@property (strong) NSMutableArray *exhibitions;

@end
