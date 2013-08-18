//
//  GalleryExhibitionsViewController.h
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryExhibitionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong) NSMutableArray *exhibitions;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
