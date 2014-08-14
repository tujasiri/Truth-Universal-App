//
//  CheckoutCart.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/29/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckoutCart.h"

@interface CheckoutCart()

@property (strong, nonatomic) NSMutableArray* itemsArray;

@end

@implementation CheckoutCart

- (id)init {
    self = [super init];
    if (self) {
        //Custom initialization
        self.itemsArray = [[NSMutableArray alloc] init];
    }
    return self;
}


+ (CheckoutCart *)sharedInstance {
    static CheckoutCart*  _sharedCart;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedCart = [[CheckoutCart alloc] init];
    });
    
    return _sharedCart;
}

- (NSArray*)itemsInCart {
    return self.itemsArray;
}

- (BOOL)containsMerchItem:(MerchItem*)mItem {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"itemNum=%@", mItem.itemNum];
    NSArray* duplicateItems = [self.itemsArray filteredArrayUsingPredicate:predicate];
    return (duplicateItems.count > 0) ? YES : NO;
}

- (void)addMerchItem:(MerchItem*)mItem {
    if (![self containsMerchItem:mItem]) {
        [self.itemsArray addObject:mItem];
    }
    
    NSLog(@"here mane");
    NSLog(@"adding mitem price==%@",mItem.itemPrice);
    NSLog(@"adding mitem name==%@",mItem.itemName);


}

- (void)removeMerchItem:(MerchItem *)mItem {
    [self.itemsArray removeObject:mItem];
}

- (void)clearCart {
    self.itemsArray = [[NSMutableArray alloc] init];
}

- (NSNumber*)total {
    
    double total = 0.0;
    for (MerchItem* merchitem in self.itemsInCart) {
        total += [merchitem.itemPrice doubleValue];
    }
    NSLog(@"total==%f",total);
    
    NSNumber *shippingTotal = [self shipping];
    
    NSLog(@"shippingTotal==%f",[shippingTotal doubleValue]);

    
    total+= [shippingTotal doubleValue];
    return @(total);
}

- (NSNumber*)shipping {
    
    double zeroVal=0.0;
    
    if(self.itemsInCart.count == 0)
        return @(zeroVal);
    
    double shipping = 3.0;
    
    for (int i=0; i < self.itemsInCart.count -1 ;++i) {
        shipping += 1.00;
    }
    NSLog(@"shipping==%f",shipping);
    
    return @(shipping);
}


@end
