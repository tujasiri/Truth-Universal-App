//
//  CheckoutCartViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/5/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "CheckoutCartViewController.h"
#import "CheckoutMerchItemCell.h"
#import "TotalCell.h"
#import "CheckoutCart.h"

@interface CheckoutCartViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *continueButtonView;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;

@property (strong, nonatomic) CheckoutCart* checkoutCart;
@property (nonatomic) int idxPath;

@end

@implementation CheckoutCartViewController

@synthesize idxPath;
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.title=@"Checkout Cart";
    
    //self.view.backgroundColor = [UIColor blackColor];
    
    self.checkoutCart = [CheckoutCart sharedInstance];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
    
    //self.tableView.bounces = NO;
    //self.tableView.scrollEnabled = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showConfirmAlert:(NSString*)nameOfItem
{
    
    NSString* itemMsg = [[NSString alloc] initWithFormat:@"Remove item::%@",nameOfItem ];
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Confirm Delete"];
    //[alert setMessage:@"Remove Item?"];
    [alert setMessage:itemMsg];
    [alert setDelegate:self]; // Notice we declare the ViewController as the delegate
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
    //[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  self.bIndex=1;
    

    
    if (buttonIndex == 0)
    {
        // Yes, do something
        NSLog(@"Clicked Yes");
        //int idxPath = (int)self.tableView.indexPathForSelectedRow.row;
        
        NSLog(@"idxPath == %i",idxPath);
       // self.bIndex = 0;
        
        //MerchItem* mitem = self.checkoutCart.itemsInCart[indexPath.row];
        
        MerchItem* mitem = self.checkoutCart.itemsInCart[idxPath];

        NSLog(@" item name ==> %@",mitem.itemName);
        
        //if((unsigned long)[CheckoutCart sharedInstance].itemsInCart.count >(int)[self.tableView numberOfRowsInSection:indexPath.section ]){
        
        [self.checkoutCart removeMerchItem:mitem];
        [self.tableView reloadData];
        
        NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
        
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:2] setBadgeValue:itmCt ];
        
    }
    else if (buttonIndex == 1)
    {
        // No
       // self.bIndex = 1;

    }
    //return buttonIndex;
}

- (int)sendClickIndex:(NSInteger)clickedIndex{

    return clickedIndex;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Items (Click item to remove from cart)" : @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.checkoutCart.itemsInCart.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section==%d",indexPath.section);
    
    
    if (indexPath.section == 0) {
        MerchItem* mItem = self.checkoutCart.itemsInCart[indexPath.row];
        CheckoutMerchItemCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
        cell.itemNameLabel.text =  mItem.itemName;
        //cell.itemPriceLabel.text = mItem.itemPrice;
        cell.itemPriceLabel.text = [NSString stringWithFormat:@"$%@", mItem.itemPrice];
        return cell;
    }
    else if(indexPath.section==1){
        TotalCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShippingCell"];
        cell.totalLabel.text = [NSString stringWithFormat:@"$%@", [self.checkoutCart shipping]];
        
        return cell;
    }
    else {
        TotalCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TotalCell"];
        cell.totalLabel.text = [NSString stringWithFormat:@"$%@", [self.checkoutCart total]];
        return cell;
    }
    /*
    else {
        TotalCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TotalCell"];
        cell.totalLabel.text = [NSString stringWithFormat:@"$%@", [self.checkoutCart total]];
        return cell;
    }
     */
    
    return nil;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.bIndex = 1;
    
    idxPath = indexPath.row;
    
    MerchItem* mitm = self.checkoutCart.itemsInCart[indexPath.row];
    NSLog(@" item name ==> %@",mitm.itemName);

    
    [self showConfirmAlert:mitm.itemName];
    
    
    
    NSLog(@"idxPath in didSelect == %d",idxPath);
    
    
    //int numRows = (int)[self.tableView numberOfRowsInSection:indexPath.section ];
    
    //NSLog(@"numRows == %d",numRows);
 
    
    
    //NSString *numOfRows = [NSString stringWithFormat:@"%d",(int)[self.tableView numberOfRowsInSection:indexPath.section ]];

    //NSLog(@"rows == %@",numOfRows);
    
    //[self.checkoutCart removeMerchItem:[
    
    /*
    MerchItem* mitem = self.checkoutCart.itemsInCart[indexPath.row];
    NSLog(@" item name ==> %@",mitem.itemName);
    
    //if((unsigned long)[CheckoutCart sharedInstance].itemsInCart.count >(int)[self.tableView numberOfRowsInSection:indexPath.section ]){
        
        [self.checkoutCart removeMerchItem:mitem];
        [self.tableView reloadData];
    
        NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
    
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:2] setBadgeValue:itmCt ];
     */

    //}
        
}


@end





