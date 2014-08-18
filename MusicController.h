//
//  subController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 8/28/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"
#import "ITunesAlbumViewController.h"


@interface MusicController : UIViewController {

    //IBOutlet UIButton *btnClickMe;
    
    IBOutlet UITableView *albumView;
    
    NSArray *albumArray;
    
    //NSDictionary *musicArray;

    NSMutableData *albumData;
    
    NSString *albumID;
    NSString *artistID;
    NSString *albumTitle;
    
    


}


//@property (nonatomic, retain) UIButton *btnClickMe;

//-(IBAction)clicked:(id)sender;


@end
