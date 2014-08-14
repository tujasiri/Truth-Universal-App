//
//  MerchItems.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/30/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchItems : NSObject<NSURLConnectionDelegate>{
    
    NSMutableData *jsonData;
    BOOL *finished;
    //NSData *jsonData;



}


@property (strong, readonly, nonatomic) NSArray *allItems;

+ (MerchItems *)sharedInstance;


@end
