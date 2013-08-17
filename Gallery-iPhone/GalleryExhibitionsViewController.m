//
//  GalleryExhibitionsViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "GalleryExhibitionsViewController.h"
#import "GalleryExhibitionDetailViewController.h"
#import "ExhibitionObject.h"
#import "GUIUtilities.h"

@interface GalleryExhibitionsViewController () {

    @private
    Boolean dataLoaded;
    UIActivityIndicatorView *spinner;
}
@end

@implementation GalleryExhibitionsViewController

@synthesize exhibitions = _exhibitions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title  = @"Exhibitions";
    
    dataLoaded = NO;
    
    //show spinner
    [self initSpinner];
    [self launchLoadData];
}

-(void) initSpinner {
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setColor:[UIColor blackColor]];
    spinner.frame = CGRectMake(
                               self.exhibitionsTableView.bounds.origin.x,
                               self.exhibitionsTableView.bounds.origin.y,
                               self.exhibitionsTableView.bounds.size.width,
                               self.exhibitionsTableView.bounds.size.height-50);
    
    [self.exhibitionsTableView addSubview:spinner];
    [spinner startAnimating];
}

-(void) hideSpinner {
    if (!spinner.isHidden) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
    }
}

-(void)launchLoadData {
    NSLog(@"Launching loading data thread...");
    
    __weak GalleryExhibitionsViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        
        // simulate loading delay from internet, show spinner
        //[NSThread sleepForTimeInterval:1];
        
        // Do work that will take a long time
        // Store data in member variables, etc.
        [weakSelf loadData];
        
        // Update the UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.exhibitionsTableView reloadData];
            [weakSelf hideSpinner];
        });
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Refreshing view...");
    // force the tableview to load
    [self launchLoadData];
}

- (void) loadData {
    NSLog(@"Loading data...");
    
    // simulate loading delay from internet, show spinner
    //[NSThread sleepForTimeInterval:1];
    
    NSString *url   = @"http://www.hua-gallery.com/exhibition_data.xml";
    
    NSError* error = nil;
    NSData* data = [NSData
                    dataWithContentsOfURL:[NSURL URLWithString:url]
                                  options:NSDataReadingUncached
                                    error:&error];
    
    if (error) {
        [GUIUtilities showErrorMessage:self message:@"Connection error"];
         NSLog(@"Could not load data from [%@] Error [%@]", url, [error localizedDescription]);
        return;
    } else {
        [GUIUtilities showErrorMessage:self message:@"Connection error"];
        NSLog(@"Loaded %i bytes from [%@]", data.length, url);
    }
    
    
    ExhibitionObject *test1 = [[ExhibitionObject alloc] initWithTitle:@"title1" description:@"description1" imageUrl:@"http://www.hua-gallery.com/images/exhibition/imgb14s.jpg"];
    ExhibitionObject *test2 = [[ExhibitionObject alloc] initWithTitle:@"title2" description:@"description2" imageUrl:@"http://www.hua-gallery.com/images/exhibition/img_19_sq.jpg"];
    ExhibitionObject *test3 = [[ExhibitionObject alloc] initWithTitle:@"title3" description:@"description3" imageUrl:@"http://www.hua-gallery.com/images/exhibition/imgb14s.jpg"];
    
    self.exhibitions = [NSMutableArray arrayWithObjects:test1, test2, test3, nil];
    
    dataLoaded = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (!dataLoaded) return 0;
    return _exhibitions.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ExhibitionsTableCell"];
 
    
    //return empty cell
    if (!dataLoaded) return cell;
    
    ExhibitionObject *exhibitionObject = [self.exhibitions objectAtIndex:indexPath.row];
    
    // Configure Cell
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *descriptionLabel = (UILabel *)[cell.contentView viewWithTag:102];
    UIImageView *imageView  = (UIImageView *)[cell.contentView viewWithTag:103];
    
    [titleLabel setText:exhibitionObject.title];
    [descriptionLabel setText:exhibitionObject.description];

    // load asynchroniciously with SDWebImage
    [imageView setImageWithURL:[NSURL URLWithString:exhibitionObject.imageUrl]
              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                       options:SDWebImageProgressiveDownload
                      progress:^(NSUInteger receivedSize, long long expectedSize) {
                          // progression tracking code
                          NSLog(@"Loading image [%@] %i/%lli", exhibitionObject.imageUrl, receivedSize, expectedSize);
                      }
                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                         // completion tracking code
                         
                         if (error) {
                             [GUIUtilities showErrorMessage:self message:@"Connection error"];
                         } else {
                             NSLog(@"Image [%@] loaded", exhibitionObject.imageUrl);
                         }
                     }
    ];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected row %i", indexPath.item);
    [self performSegueWithIdentifier:@"exhibitionDetailViewSegueId" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"exhibitionDetailViewSegueId"])
    {
        ExhibitionObject *exhibitionObject = [self.exhibitions objectAtIndex:[self.tableView indexPathForSelectedRow].row];
     
        GalleryExhibitionDetailViewController *viewController = [segue destinationViewController];
        viewController.exhibitionObject = exhibitionObject;
    }
}

@end
