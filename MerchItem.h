//
//  MerchItem.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/29/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchItem : NSObject

@property (strong, nonatomic) NSNumber* itemNum;
@property (strong, nonatomic) NSString* itemName;
@property (strong, nonatomic) NSString* shortDesc;
@property (strong, nonatomic) NSString* imageId;
@property (strong, nonatomic) NSString* itemType;

@property (strong, nonatomic) NSString* longDesc;



@property (strong, nonatomic) NSNumber* itemPrice;        //$$
@property (strong, nonatomic) NSNumber* stockQty;        //#


@end
