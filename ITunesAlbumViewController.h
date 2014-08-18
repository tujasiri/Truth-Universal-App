//
//  ITunesAlbumViewController.h
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 9/4/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicController.h"
#import "ITunesSongViewController.h"
#import "MBProgressHUD.h"


@interface ITunesAlbumViewController : UIViewController{
    
    IBOutlet UITableView *songsView;
    
    NSString *albumId;
    
    NSArray *songArray;
    
    //NSDictionary *musicArray;
    
    NSMutableData *albumDataFull;
    
    NSURL *albumViewSongUrl;
    NSString *albumViewSongName;
    
    /*NSString *albumID;
    NSString *artistID;*/
    
    MBProgressHUD *HUD;
    

}
@property(nonatomic, copy) NSString *albumId;

@end
