//
//  MerchInventory.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/1/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryTabBarItem.h"
#import "MBProgressHUD.h"

@interface MerchInventoryViewController : UIViewController{

MBProgressHUD *merchHUD;
    
}

//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
//@property (nonatomic, assign) UIActivityIndicatorView *activityIndicator;

//@property (nonatomic, assign) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet InventoryTabBarItem *Inventory;



- (void)show_mdprogress;



@end
