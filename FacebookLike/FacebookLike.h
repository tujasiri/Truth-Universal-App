//
//  FacebookLike.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 2/10/14.
//  Copyright (c) 2014 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    FBButtonSizeSmall = 0,
    FBButtonSizeLarge = 1
} FBTwitterFollowButtonSize;

@interface FacebookLike : UIButton

@property (nonatomic,retain)UIWebView* socialWebViewLocal;

@property (nonatomic, strong) UIViewController* pvc;


@property (nonatomic, strong) NSString *facebookAccount;
@property (nonatomic) FBTwitterFollowButtonSize buttonSize;

- (instancetype)initWithOrigin:(CGPoint)origin
                facebookAccount:(NSString *)facebookAccount
                       andSize:(FBTwitterFollowButtonSize)size
                      parentVC:(UIViewController*)pvc;
@end
