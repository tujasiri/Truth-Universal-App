//
//  MerchView.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/21/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "MerchTabBarView.h"

@implementation MerchTabBarView

@synthesize tabBarController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"didSelectItem: %d", item.tag);
    
    }

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title merch: %@", viewController.title);
    

    
    if (viewController == tabBarController.moreNavigationController)
    {
        tabBarController.moreNavigationController.delegate = self;
    }
}

- (void)viewDidLoad {
    
    self.tabBarController.delegate=self;

    [super viewDidLoad];
    
    UIAlertView *inventoryTableViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"TAB BAR CONTROLLER LOADED!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [inventoryTableViewMsg show];
    
    NSArray *tabBarItems = self.tabBarController.tabBar.items;
    
    // Add your code below! The property for MainViewController's
    // tab bar controller is named 'tabBarController'.
    
    UITabBarItem *selectedTab = [self.tabBarController setSelectedIndex:2];
    
    NSString *bValue = [NSString stringWithFormat:@"%@",3];
    
    selectedTab.badgeValue = bValue;
    
    
}


@end
