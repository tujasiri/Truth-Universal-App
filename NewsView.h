//
//  NewsView.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/27/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailController.h"
#import "NewsController.h"

@interface NewsView : UIView {

NSString *nArticleText;
UIImage *nArticleImage;

    
}

@property (nonatomic,copy) NSString *nArticleText;
@property (nonatomic,copy) UIImage *nArticleImage;



@end
