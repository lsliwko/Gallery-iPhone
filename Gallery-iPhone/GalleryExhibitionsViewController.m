//
//  GalleryExhibitionsViewController.m
//  Gallery-iPhone
//
//  Created by Leszek Sliwko on 16/08/2013.
//  Copyright (c) 2013 Leszek Sliwko. All rights reserved.
//
#import "GalleryExhibitionsViewController.h"
#import "GalleryExhibitionDetailViewController.h"
#import "ExhibitionObject.h"
#import "GUIUtilities.h"
#import "GallerySettingsManager.h"

@interface GalleryExhibitionsViewController () {

    @private
    Boolean dataLoaded;
    UIActivityIndicatorView *spinner;
}
@end

@implementation GalleryExhibitionsViewController

@synthesize exhibitions;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title  = @"Exhibitions";
     
    dataLoaded = NO;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = nil;
    
    //show spinner
    [self initSpinner];
}

-(void) initSpinner {
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setColor:[UIColor blackColor]];
    spinner.frame = CGRectMake(
                        self.view.bounds.origin.x,
                        self.view.bounds.origin.y,
                        self.view.bounds.size.width,
                        self.view.bounds.size.height-100
                    );
    
    [self.view addSubview:spinner];
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
 
        // Do work that will take a long time
        // Store data in member variables, etc.
        [weakSelf loadData];
        
        // Update the UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //first time animate
            if (!spinner.isHidden) {
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [weakSelf.tableView reloadData];
            }
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
    
    NSError* error = nil;
    NSMutableArray *exhibitionsTmp = [[GallerySettingsManager sharedManager] loadExhibitions:&error];
    if (error) {
        [GUIUtilities showErrorMessage:self message:@"Connection error"];
        return;
    }
    
    self.exhibitions    = exhibitionsTmp;
    
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
    return self.exhibitions.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExhibitionsTableCell"];
 
    
    //return empty cell
    if (!dataLoaded) return cell;
    
    ExhibitionObject *exhibitionObject = [self.exhibitions objectAtIndex:indexPath.row];
    
    // Configure Cell
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *descriptionLabel = (UILabel *)[cell.contentView viewWithTag:102];
    UIImageView *imageView  = (UIImageView *)[cell.contentView viewWithTag:103];
    
    [titleLabel setText:exhibitionObject.title];
    [descriptionLabel setText:exhibitionObject.description];

    [GUIUtilities loadImageViewAsync:self
                         uiImageView:imageView
                            imageUrl:exhibitionObject.imageUrl
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                         forceResize:NO
    ];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
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
