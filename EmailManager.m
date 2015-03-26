//
//  EmailManager.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/9/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "EmailManager.h"
#import "CheckoutCart.h"

#import "AFNetworking.h"

#define EMAIL_POST_URL @"http://truthuniversal.com/ios/stripe-email.php"



@interface EmailManager()

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* zip;

//@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;

@end

@implementation EmailManager

//- (id)initWithRecipient:(NSString*)name recipientEmail:(NSString *)email {
    
- (id)initWithRecipient:(NSString*)name recipientEmail:(NSString *)email recipientAddress:(NSString *)address recipientCity:(NSString*)city recipientState:(NSString*)state recipientCountry:(NSString*)country recipientZip:(NSString*)zip
{

    self = [super init];
    if (self) {
        self.name = name;
        self.email = email;
        self.address = address;
        self.city = city;
        self.state = state;
        self.country = country;
        self.zip = zip;
    }
    return self;
}

- (void)sendConfirmationEmail {
    [self sendConfirmationEmailWithSuccessBlock:nil failureBlock:nil];
}

- (void)sendConfirmationEmailWithSuccessBlock:(void(^)(void))successBlock
                                 failureBlock:(void(^)(void))failureBlock {
    
    CheckoutCart* checkCart = [CheckoutCart sharedInstance];
    
    NSMutableDictionary* postReqDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray* itemsArray = [[NSMutableArray alloc] init];
    
    for (MerchItem* mitem in checkCart.itemsInCart) {
        NSMutableDictionary* itemDict = [[NSMutableDictionary alloc] init];
        
        NSLog(@"itemName == %@",mitem.itemName);
        NSLog(@"itemPrice == %@",mitem.itemPrice);

        itemDict[@"itemName"] = mitem.itemName;
        itemDict[@"itemPrice"] = mitem.itemPrice;
        
        [itemsArray addObject:itemDict];
    }
    
    
    
    postReqDictionary[@"recipientName"] = self.name;
    postReqDictionary[@"recipientEmail"] = self.email;
    postReqDictionary[@"recipientAddress"] = self.address;
    postReqDictionary[@"recipientCity"] = self.city;
    postReqDictionary[@"recipientState"] = self.state;
    postReqDictionary[@"recipientZip"] = self.zip;
    postReqDictionary[@"recipientCountry"] = self.country;
    postReqDictionary[@"recipientTotal"] = checkCart.total;
    postReqDictionary[@"recipientShipping"] = checkCart.shipping;


    postReqDictionary[@"recipientItems"] = itemsArray;
    
  
    
    
    //NSLog(@"stripe card no%@",self.stripeCard.number);
    
    
    //new AFNeworking Request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:EMAIL_POST_URL parameters:postReqDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if (successBlock) successBlock();
        
        NSLog(@"responseString == %@",operation.responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject){
        
        if (failureBlock) failureBlock();
        
    }
     
     ];
    
    //4
    /*
     NSMutableURLRequest* request = [httpClient requestWithMethod:@"POST" path:nil parameters:postRequestDictionary];
     
     self.httpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     [self chargeDidSucceed];
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
     [self chargeDidNotSuceed];
     }];
     
     [self.httpOperation start];
     */
    
}

@end
