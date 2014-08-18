//
//  ITunesSongViewController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 9/10/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITunesSongViewController : UIViewController{

    IBOutlet UIWebView *songWebView;
    
    NSURL *songUrl;
    NSString *songName;

}

@property (nonatomic,retain) UIWebView *songWebView;
@property (nonatomic,copy) NSURL *songUrl;
@property (nonatomic,copy) NSString *songName;


@end
