//
//  NewsDetailController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/26/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsView.h"

@interface NewsDetailController : UIViewController {
    
    UIImage *articleImage;
    NSURL *articleLink;
    NSString *articleText;
    
    IBOutlet UIView *nView;
    
}

@property (nonatomic,copy) UIImage *articleImage;

@property (nonatomic,copy) NSURL *articleLink;

@property (nonatomic,copy) NSString *articleText;





@end
