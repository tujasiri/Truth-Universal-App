//
//  FeaturedItemViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/19/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "FeaturedItemViewController.h"
#import "CheckoutCart.h"
#import "MerchItem.h"
#import "MerchItems.h"
#import "MBProgressHUD.h"




@interface FeaturedItemViewController ()

@property (strong, nonatomic) IBOutlet UILabel *merchItemShortDescLabel;
@property (strong, nonatomic) IBOutlet UIImageView *merchItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *merchItemLongDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *merchItemTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *merchItemPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;

- (IBAction)addToCartButtonTapped:(id)sender;



@end

@implementation FeaturedItemViewController

-(void)initHUD{

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view.superview];
    HUD.labelText=@"Loading...";
    HUD.dimBackground=YES;

    [self.navigationController.view.superview addSubview:HUD];
}

-(void)showHUD{
    
    [self initHUD];
    [HUD show:YES];
  

}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"Leaving...");
    
    
    
/*

    dispatch_async(
                  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                  [HUD show:YES];
                      
                      NSLog(@"doin this featured");
                      //[MBProgressHUD showHUDAddedTo:self.navigationController.view.superview animated:YES];
                     
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                    
                          NSLog(@"Block 2a Leaving");
                          NSAssert([NSThread isMainThread], @"Wrong thread!");
                          NSLog(@"Block 2b Leaving");
                          
                          [HUD hide:YES];

                          //[MBProgressHUD hideHUDForView:self.navigationController.view.superview animated:YES];
                          
                      });
                  });
 

    */

    
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    //HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    //[HUD showWhileExecuting:@selector(tabBarController:didSelectViewController:) onTarget:self withObject:nil animated:YES];
    


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        

    }
    
    
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    NSLog(@"selected item==%@",item.title);

}

- (void)tabBarController:(UITabBarController *)tabBarController
 addItemCountToBadge:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title featured: %@", viewController.title);
    
    
    UITabBarItem *tbi = viewController.tabBarController.tabBar.items[2];
    
    NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[MerchItems sharedInstance].allItems.count];
    
    tbi.badgeValue = itmCt;
    
    /*
    
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Launching Inventory" message:[NSString stringWithFormat:@"title ==> %@",viewController.title] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
     */
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    if (viewController == tabBarController.moreNavigationController)
    {
        tabBarController.moreNavigationController.delegate = self;
    }
    
}


- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title feat: %@", viewController.title);
    NSLog(@"controller self.title feat: %@", self.title);
    
    if([NSStringFromClass([viewController class]) isEqualToString:@"FeaturedItemViewController"]){
        
        NSLog(@"FEATURED VIEW CONTROLLER!");
        //[self performSelectorInBackground:@selector(showHUD) withObject:nil];

    }
    
    /*
    if ([NSThread isMainThread])
    {
        NSLog(@"Main Thread feat");
    }
     */
    
    
    //if(viewController){
        
        NSLog(@"View is LOADED!...YUP");
    
       if(self.inventoryViewWasLoaded){
        NSLog(@"Inventory View is LOADED!...YUP");

        
    }
    
    
/*
    if(([viewController.tabBarItem.title isEqualToString:@"Inventory"]) && !([self.title isEqualToString:@"Inventory Navigation Controller" ]) && !([NSStringFromClass([viewController class]) isEqualToString:@"UINavigationController" ])){
        
        NSLog(@"INVENTORY TAB!");
        
    
        [self performSelectorInBackground:@selector(showHUD) withObject:nil];
        
    
    }
 */
    
    if([viewController.tabBarItem.title isEqualToString:@"Inventory"]){
        
        if (!(self.inventoryViewWasLoaded)){
            self.inventoryViewWasLoaded=YES;
            NSLog(@"justloaded view");
            [self performSelectorInBackground:@selector(showHUD) withObject:nil];

        }
        else {
            //remove HUD
            NSLog(@"already loaded mane");
            
            //[MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];

            
        }
        

        
        NSLog(@"tabbar item is %@",viewController.tabBarItem.title);
        
        //if(self.inventoryViewWasLoaded)
        
        
    }


    UITabBarItem *tbi = viewController.tabBarController.tabBar.items[2];
    
    /*tbi.badgeValue = @"1";
    
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Launching Inventory" message:[NSString stringWithFormat:@"title ==> %@",viewController.title] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
     */
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    if (viewController == tabBarController.moreNavigationController)
    {
        tabBarController.moreNavigationController.delegate = self;
    }
   
}

-(void)loadView{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [super loadView];
    
    NSLog(@"in loadView...");
    
   
}

-(void)viewDidAppear:(BOOL)animated
{

    //[self performSelectorInBackground:@selector(showHUD) withObject:nil];

    [HUD hide:YES];
}

- (void)viewDidLoad {
    self.tabBarController.delegate = self;

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
        NSLog(@"xxxxxxxx");
    
       NSLog(@"in viewDidLoad...");
    
    
    

    [self performSelectorInBackground:@selector(showHUD) withObject:nil];

    //[self showHUD];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
    
    //[self.view sendSubviewToBack:backgroundImage];
    
    
    
    //self.view.backgroundColor = [UIColor clearColor];
    
    
    NSString *tbiTitle = [NSString stringWithFormat:@"%@",self.tabBarItem.title];
    
    NSArray *tabBarItems = self.tabBarController.tabBar.items;
    
    
    for(UITabBarItem *tbitem in tabBarItems){
        NSLog(@"tabbar item==%@",tbitem.title);
        NSLog(@"tabbar item tag==%d",tbitem.tag);
        
        
        
        //tbitem.badgeValue = @"0";

    }

    
    NSLog(@"title ==> %@",tbiTitle);
    NSLog(@"LOAD");

    /*
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:[NSString stringWithFormat:@"title ==> %@",tbiTitle] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
     
     */
    
    

    
    self.merchitem = [MerchItems sharedInstance].allItems[10]; //feature item as default

    
    [self loadData];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    self.addToCartButton.selected = [checkoutCart containsMerchItem:self.merchitem ] ? YES : NO;
    
}

- (void)loadData {
    
    self.merchItemShortDescLabel.text = self.merchitem.itemName;
    
    NSString* imageURLString = [NSString stringWithFormat:@"https://www.2checkout.com/va/public/render_image?image_id=%@",self.merchitem.imageId];
    
    NSLog(@"imageId==> %@",self.merchitem.imageId);
    
    NSString *name = self.nibName;
    
    NSLog(@"%@",name);
    
    NSURL* imageURL = [NSURL URLWithString:imageURLString];
    
    //NSURL * imageURL = [NSURL URLWithString:albumImageUrl];
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    
    UIImage * image = [UIImage imageWithData:imageData];
    
    [self.merchItemImageView setImage:image];
    
    self.merchItemLongDescLabel.text = [NSString stringWithFormat:@"Description: %@", self.merchitem.longDesc];
    
    self.merchItemTypeLabel.text = [NSString stringWithFormat:@"Item Type: %@", self.merchitem.itemType];
    
    self.merchItemPriceLabel.text = [NSString stringWithFormat:@"Price: $%@", self.merchitem.itemPrice];
}

- (IBAction)addToCartButtonTapped:(id)sender {
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    
    NSLog(@"Adding item x...");
    
    

    
    if (!self.addToCartButton.selected) {
        [checkoutCart addMerchItem:self.merchitem];
        self.addToCartButton.selected = YES;
        NSLog(@"Adding item...");
        //[self addItemCountToBadge];
        
        NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
        
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:2] setBadgeValue:itmCt ];
    }
    else {
        [checkoutCart removeMerchItem:self.merchitem];
        self.addToCartButton.selected = NO;
    }
}

@end



