//
//  NewsController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/23/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailController.h"

@interface NewsController : UIViewController {

    IBOutlet UITableView *newsView;
    
    NSArray *newsArray;
    
    //NSDictionary *musicArray;
    
    NSMutableData *newsData;
    
    UIImage *newsArticleImage;
    NSURL *newsArticleLink;
    NSString *newsArticleText;
    
}

@property (nonatomic,copy) UIImage *newsArticleImage;

@property (nonatomic,copy) NSURL *newsArticleLink;

//@property (nonatomic,copy) NSString *newsArticleText;

    


@end
