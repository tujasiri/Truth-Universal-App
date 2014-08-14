//
//  EmailManager.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/9/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailManager : NSObject

//- (id)initWithRecipient:(NSString*)name recipientEmail:(NSString *)email;
- (id)initWithRecipient:(NSString*)name recipientEmail:(NSString *)email recipientAddress:(NSString *)address recipientCity:(NSString*)city recipientState:(NSString*)state recipientCountry:(NSString*)country recipientZip:(NSString*)zip;

- (void)sendConfirmationEmail;

- (void)sendConfirmationEmailWithSuccessBlock:(void(^)(void))successBlock
                                 failureBlock:(void(^)(void))failureBlock;

@end