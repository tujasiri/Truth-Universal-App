//
//  MerchInventory.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/1/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "MerchInventoryViewController.h"
#import "InventoryCell.h"
#import "MerchItem.h"
#import "MerchItems.h"
#import "MerchItemViewController.h"
#import "DejalActivityView.h"
#import "CheckoutCart.h"

// Add to top of file
#import <dispatch/dispatch.h>
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"

// Add new instance variable
dispatch_queue_t backgroundQueue;




@interface MerchInventoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) IBOutlet UITableView* tableView;



//@property (weak, nonatomic) IBOutlet InventoryTabBarItem *Inventory;


@end

@implementation MerchInventoryViewController


- (void)didAddSubview:(UIView *)subview{
    for (UIView *view in self.navigationController.view.subviews){
        if([view isKindOfClass:[MBProgressHUD class]]){
            [self.navigationController.view bringSubviewToFront:view];
            NSLog(@"Bringing it to the front...");
            break;
        }
    }
    
}
//

-(void)superLoadView{

    [super loadView];
    
    //[SVProgressHUD showWithStatus:@"Loading..."];
    
    
    
    
    
    
    

    /**/
}//loadview


-(void)initMerchHUD{
    
    //UIWindow *globalWindow = [UIApplication sharedApplication].keyWindow;
    
    //merchHUD = [[MBProgressHUD alloc] initWithView:globalWindow];
    
    merchHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view.superview];
    
    //merchHUD.delegate=self;

    
 

    [self.navigationController.view.superview addSubview:merchHUD];
        
    
    
    //[globalWindow addSubview:merchHUD];

    
    //[self didAddSubview:merchHUD];
    
}


-(void)startActivityAndLoadSuperView{
    
    //backgroundQueue = dispatch_queue_create("truthuniversal.testqueue", NULL);
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    //[view addSubview:ac]; // <-- Your UIActivityIndicatorView
    //self.tableView.tableHeaderView = view;
    
    //UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    
    //self.view = view;
    //[view release];
    
    /*
    dispatch_async(backgroundQueue, ^(void) {
        
        //[view setBackgroundColor:[UIColor redColor]];
        
        //.[self.view addSubview:view];
        
        //[self.tableView reloadData];
     
     
        //UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loading table view." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        //[inventoryTableViewMsg show];
        
        //[DejalActivityView activityViewForView:self.view];

        
        
    });
    
*/
    
    //self.view.removeFromSuperview;
    
    //[DejalActivityView activityViewForView:self.view];
    
    /*
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loading table view." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
    */

}


-(void)loadView
{
    
    
    [self superLoadView];
    

    //[super loadView];


    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loading table view." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        //[inventoryTableViewMsg show];
        

    }
    
    
    
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    /*
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"View will appear." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
     */
    
    /*
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loading table view." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
     
     */
    
    //[merchHUD show:YES];
    
    //[self performSelectorInBackground:@selector(showHUD) withObject:nil];

    
    if ([self isViewLoaded]){
        NSLog(@"view is LOADED!");
    }
    else
        NSLog(@"view is NOT LOADED!");
    
    
    //[self initMerchHUD];
    
    //[merchHUD hide:YES];
    
    //[merchHUD show:YES];
    
    //[[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES]  setLabelText:@"Loading"];
    
    
    

    
    
    
    

     /*xxxxx viewWillAppear */
    
    //[self initMerchHUD];
    //[merchHUD show:YES];

    


}

-(void)showHUD{
    
    [self initMerchHUD];
    [merchHUD show:YES];
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //self.title=@"Merchandise Inventory";
    //self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
    
    
    
    /** viewDidLoad **/
    

    
    NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
    
    
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:2] setBadgeValue:itmCt ];


}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    //[super viewDidAppear:];
    
    //[merchHUD hide:YES];
    //[merchHUD show:YES];
    
    
    //[MBProgressHUD hideAllHUDsForView:self.navigationController.view.superview animated:YES];
    [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];



}

- (void)show_mdprogress
{
/*
    dispatch_sync(
                  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                      
                      NSLog(@"doin this");
                      //[MBProgressHUD showHUDAddedTo:self.navigationController.view.superview animated:YES];
                      
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          NSLog(@"Block 2a");
                          NSAssert([NSThread isMainThread], @"Wrong thread!");
                          NSLog(@"Block 2b");
                          //[MBProgressHUD hideHUDForView:self.navigationController.view.superview animated:YES];
                          
                      });
                  });
 
 */

}

#pragma mark - UITableViewDataSource methods

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImage *myImage = [UIImage imageNamed:@"tu_app_header.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,300,100);
    
    if(section==0)
        return imageView;
    
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 70;
    
    return 0;
}
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [MerchItems sharedInstance].allItems.count;
    
    //return 4;
    
    
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        });
     
     */
 
    
    
    MerchItem* merchitem = [MerchItems sharedInstance].allItems[indexPath.row];
    
    
    InventoryCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"InventoryCell"];
    
    if (cell == nil){
        NSLog(@"cell is nil");
        cell = [[InventoryCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"InventoryCell"];
        
    }
    
    
    
    NSString* imageURLString = [NSString stringWithFormat:@"https://www.2checkout.com/va/public/render_image?image_id=%@",merchitem.imageId];
    
    NSURL* imageURL = [NSURL URLWithString:imageURLString];
    
   
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    
    
    
    //MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
	//[self.navigationController.view addSubview:HUD];
	
	// Register for HUD callbacks so we can remove it from the window at the right time
	//HUD.delegate = self;
	
    
    

	// Show the HUD while the provided method executes in a new thread
	//[HUD showWhileExecuting:@selector(this.cellForRowAtIndexPath) onTarget:self withObject:nil animated:YES];
    
   
    
    //dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    //
   // dispatch_after(popTime, dispatch_get_main_queue(), ^(void){


    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    //dispatch_sync(queue, ^{
    
    
    
    dispatch_async(queue, ^{
        
        UIImage * image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), ^{


        
        //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
        [cell.merchItemImageView setImage:image];
    
        //test code
        [cell setNeedsLayout];

    
    
    

    
  
        
            //[MBProgressHUD hideHUDForView:self.navigationController.view.superview animated:YES];
        


    //[[cell.merchItemImageView setImageWithURL:[NSURL URLWithString:merchURLString]]];
            
    
    
    NSLog(@"shortDesc==%@",merchitem.itemName);
    NSLog(@"itemPrice==%@",merchitem.itemPrice);

    cell.merchItemShortDesc.text =  [NSString stringWithFormat:@"%@",merchitem.itemName];
    cell.merchItemPrice.text = [NSString stringWithFormat:@"$%@",merchitem.itemPrice];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
     });
        
     });
    
   

    
    //});
    
    //[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
    

    return cell;
    
     

}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"toMerchItemViewController" sender:nil];
}

#pragma mark - UIStoryboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MerchItemViewController* viewController = (MerchItemViewController*) segue.destinationViewController;
    viewController.merchitem = [MerchItems sharedInstance].allItems[self.selectedIndex];
}



@end
