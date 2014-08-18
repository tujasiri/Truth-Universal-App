//
//  InventoryCell.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/1/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *merchItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *merchItemShortDesc;
@property (strong, nonatomic) IBOutlet UILabel *merchItemPrice;

@end
