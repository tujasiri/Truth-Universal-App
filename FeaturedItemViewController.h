//
//  FeaturedItemViewController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/19/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "ViewController.h"
#import "MerchItem.h"
#import "MBProgressHUD.h"

@interface FeaturedItemViewController : UIViewController<UITabBarControllerDelegate>{
MBProgressHUD *HUD;
    
}

@property (strong, nonatomic) MerchItem* merchitem;
@property (nonatomic) BOOL *inventoryViewWasLoaded;


- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController;

@end


