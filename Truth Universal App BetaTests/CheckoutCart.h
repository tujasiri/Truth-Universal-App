//
//  CheckoutCart.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/29/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MerchItem.h"

@interface CheckoutCart : NSObject

+ (CheckoutCart *)sharedInstance;

- (NSArray*)itemsInCart;

- (BOOL)containsMerchItem:(MerchItem*)mItem;

- (void)addMerchItem:(MerchItem*)mItem;

- (void)removeMerchItem:(MerchItem*)mItem;

- (void)clearCart;

- (NSNumber*)total;

- (NSNumber*)shipping;

@end
