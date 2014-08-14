//
//  MerchItems.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/30/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "MerchItems.h"
#import "MerchItem.h"
#import <dispatch/dispatch.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"

@implementation MerchItems

+ (MerchItems *)sharedInstance {
    

    static MerchItems*  _sharedItems;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{

        _sharedItems = [[MerchItems alloc] init];
    });
    
    return _sharedItems;
}

- (id)init
{
    if((self = [super init]))
    {
        //[self getData];
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        /*
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            _allItems = [self loadItemsFromJSON];
            dispatch_async(dispatch_get_main_queue(), ^{
                //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

            });
        });
         
        */
        
       _allItems = [self loadItemsFromJSON];
    }
    return self;
}

- (void)getData{
    
    
}




- (NSArray *)loadItemsFromJSON {
    
    NSLog(@"LOADING JSON!");
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
        /*
    UIAlertView *loadViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loading items." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [loadViewMsg show];
         
     */
    
    
    //NSMutableArray* merchArray = [NSMutableArray alloc];
    
    /*
     
     //new AFNeworking Request
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     
     [manager POST:@"http://truthuniversal.com/merchjson" parameters:Nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     
     
     
     NSDictionary* jsonArray = [NSJSONSerialization
     JSONObjectWithData:operation.responseData
     options:kNilOptions
     error:nil];
     
     
     
     NSLog(@"merch—response--->%@", operation.response);
     //NSLog(@"stripe--response status code--->%@", operation.response["@status code"]);
     NSLog(@"merch-response object--->%@", jsonArray);
     NSLog(@"merch—response string--->%@", operation.responseString);
     //NSLog(@"stripe--response array--->%@", responseArray);
     
     
     
     //success message
     
     NSLog(@"success!!");
         
       NSMutableArray*  merchArray = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
         
         for (NSDictionary* merchDictionary in jsonArray) {
             MerchItem* mItem = [[MerchItem alloc] init];
             mItem.itemNum = [ merchDictionary objectForKey:@"mt_item_num"];
             mItem.itemName = merchDictionary[@"mt_item_desc_short"];
             //mItem.shortDesc = merchDictionary[@"breed"];
             mItem.longDesc = merchDictionary[@"mt_item_desc_long"];
             mItem.imageId = merchDictionary[@"mt_image_id"];
             mItem.itemType = merchDictionary[@"mt_item_type"];
             mItem.itemPrice = merchDictionary[@"mt_item_price"];
             mItem.stockQty = merchDictionary[@"mt_stock_qty"];
             [merchArray addObject:mItem];
             
             NSLog(@"%@",[merchDictionary objectForKey:@"mt_item_desc_short"]);
             NSLog(@"%@",mItem.itemNum);
             
         }
         NSLog(@"merchArray == %@",merchArray);
     
     
     
     } failure:^(AFHTTPRequestOperation *operation, id responseObject){
     
     //failed message
     NSLog(@"failure!!");
     
     }
     
     
     
     ];

     */
     

    
    NSString *urlString = [NSString stringWithFormat:@"http://truthuniversal.com/merchjson"];
    
    
    NSURL *merchURL = [NSURL URLWithString:urlString];
    

    NSURLRequest *merchRequest = [NSURLRequest requestWithURL:merchURL];
    

    NSURLConnection * connection = [[NSURLConnection alloc]
                                    initWithRequest:merchRequest
                                    delegate:self startImmediately:NO];

    
    //[[NSURLConnection alloc] initWithRequest:merchRequest delegate:self startImmediately:YES];
    
    
    
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
    
    finished = FALSE;
    
    while(!finished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"here!!");
        
    }
    
    
    NSError* error;

    
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    

    
     
     //NSLog(@"jsonArray == %@",jsonArray);
    
    
    NSMutableArray* merchArray = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    
    for (NSDictionary* merchDictionary in jsonArray) {
        MerchItem* mItem = [[MerchItem alloc] init];
        mItem.itemNum = [ merchDictionary objectForKey:@"mt_item_num"];
        mItem.itemName = merchDictionary[@"mt_item_desc_short"];
        //mItem.shortDesc = merchDictionary[@"breed"];
        mItem.longDesc = merchDictionary[@"mt_item_desc_long"];
        mItem.imageId = merchDictionary[@"mt_image_id"];
        mItem.itemType = merchDictionary[@"mt_item_type"];
        mItem.itemPrice = merchDictionary[@"mt_item_price"];
        mItem.stockQty = merchDictionary[@"mt_stock_qty"];
        [merchArray addObject:mItem];
        
        NSLog(@"%@",[merchDictionary objectForKey:@"mt_item_desc_short"]);
        NSLog(@"%@",mItem.itemNum);

    }
    NSLog(@"merchArray == %@",merchArray);
    
    return merchArray;
        
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    jsonData = [[NSMutableData alloc] init];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    if(data == nil){
        UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nilly is the dilly." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [testView show];
    }
    else
    
    [jsonData appendData:data];
    
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    finished = TRUE;

    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"here");
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Download could not complete.  Please make sure you are connected to 4G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [errorView show];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    finished = TRUE;

}




@end
