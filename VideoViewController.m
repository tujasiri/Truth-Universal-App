//
//  VideoViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 2/3/14.
//  Copyright (c) 2014 tajiri ujasiri. All rights reserved.
//

#import "VideoViewController.h"
#import "AFNetworking.h"
//#import "AFURLSessionManager.h"

//
//#define YOUTUBE_POST_URL @"http://gdata.youtube.com/feeds/api/playlists/PLT6MGgEFxoh6hX6QDpF8JHd-NOx3Hxh43?alt=jsonc&v=2"

#define YOUTUBE_POST_URL @"http://truthuniversal.com/ios/youtubejson.php"



@interface VideoViewController () <UIWebViewDelegate>


@end

@implementation VideoViewController


-(UIWebView*)createYtWebview :(NSString*)vidLink :(int)xcoord :(int)ycoord: (NSString*)vidTitle{
    //UIWebView *youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,320,320)];
    
    UIWebView *youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(xcoord,ycoord,420,420)];
    
    youTubeWebView.allowsInlineMediaPlayback=YES;
    youTubeWebView.mediaPlaybackRequiresUserAction=NO;
    youTubeWebView.mediaPlaybackAllowsAirPlay=YES;
    youTubeWebView.delegate=self;
    youTubeWebView.scrollView.bounces=NO;
   

    
    //NSString *linkObj=@"http://www.youtube.com/v/X1yJhIZA1wI";//@"http://www.youtube.com/v/6MaSTM769Gk";
    NSLog(@"vidLink_________________%@",vidLink);
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    .youtube {\
    margin-left:auto;margin-right:auto;display:block;width:420;text-align:center;text-color:white;}\
    body {\
    background-color:#ededed;color:white}\\</style>\\</head><body style=\"margin:0\">\\<div class=\"youtube\">\\<embed  webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"420\" height=\"320\"></embed>\\<p class=\"youtube\" style=\"color:black;\">Title: %@</p><div></body></html>";
    

    NSString *html = [NSString stringWithFormat:embedHTML, vidLink, vidTitle];
    
    NSLog(@"embedHTML ==> %@",html);

    
    [youTubeWebView loadHTMLString:html baseURL:nil];

    return youTubeWebView;

}

//-(NSMutableArray *)buildArrayOfWebViews{

-(NSString*)makeLinkHighQuality:(NSString*)ytLink{

    NSString* newLink = [[NSString alloc] initWithFormat:@"%@%@",ytLink,@"&amp;vq=large"];
    
    return newLink;

}
    
-(NSMutableArray *)buildArrayOfWebViews:(NSDictionary*)ytArray{

    
    NSMutableArray *arrayOfViews = [[NSMutableArray alloc] init];
    
    //for(int x=0;x <5; x++){
    int x=0;
    
    for (NSDictionary* ytDictionary in [ytArray objectForKey:@"items"]) {

        NSString* ytUrl = [[[ytDictionary objectForKey:@"video"] objectForKey:@"content"] objectForKey:@"5"];
        
        NSString* ytTitle = [[ytDictionary objectForKey:@"video"] objectForKey:@"title"];

        
        NSString* ytUrlHQ = [self makeLinkHighQuality:ytUrl];

        UIWebView* tmpUiWebView = [[UIWebView alloc] init];
        
        //NSString *linkObj=@"http://www.youtube.com/v/X1yJhIZA1wI";
        
        //NSString *linkObj=[NSString stringWithString:ytUrl];
        
        NSString *linkObj=[NSString stringWithString:ytUrlHQ];


        
        //UIWebView *tmpUiWebView = [UIWebView alloc];
        
        tmpUiWebView = [self createYtWebview:linkObj :(self.view.bounds.size.width/2)/2 :(x++*450):ytTitle];
        
        [arrayOfViews addObject:tmpUiWebView];

    }

    return arrayOfViews;
}



-(void)viewDidLoad{
/*
UIWebView *youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,320,320)];

youTubeWebView.allowsInlineMediaPlayback=YES;
youTubeWebView.mediaPlaybackRequiresUserAction=NO;
youTubeWebView.mediaPlaybackAllowsAirPlay=YES;
youTubeWebView.delegate=self;
youTubeWebView.scrollView.bounces=NO;

NSString *linkObj=@"http://www.youtube.com/v/X1yJhIZA1wI";//@"http://www.youtube.com/v/6MaSTM769Gk";
NSLog(@"linkObj1_________________%@",linkObj);
NSString *embedHTML = @"\
<html><head>\
<style type=\"text/css\">\
body {\
background-color: transparent;color: white;}\\</style>\\</head><body style=\"margin:0\">\\<embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"320\" height=\"320\"></embed>\\</body></html>";

NSString *html = [NSString stringWithFormat:embedHTML, linkObj];
[youTubeWebView loadHTMLString:html baseURL:nil];
    
    
    
[self.view addSubview:youTubeWebView];
 */
    
    /*
    NSString *linkObj=@"http://www.youtube.com/v/X1yJhIZA1wI";
    
    //UIWebView *tmpUiWebView = [UIWebView alloc];
    
    UIWebView *tmpUiWebView = [self createYtWebview:linkObj];
     
     */
    [super viewDidLoad];
    
    UILabel* tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 300, 40)];
    tlabel.text=self.navigationItem.title;
    tlabel.text=@"TRUTH UNIVERSAL VIDEOS!";
    tlabel.textColor=[UIColor blackColor];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth=YES;
    self.navigationItem.titleView=tlabel;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 3);
    
    [self.view addSubview:scrollView];
    
    //get YouTube video data
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:YOUTUBE_POST_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSDictionary* jsonObject = [NSJSONSerialization
        
        
        NSDictionary* jsonObject = [NSJSONSerialization
                                    JSONObjectWithData:operation.responseData
                                    options:kNilOptions
                                    error:nil];
        
        //NSArray *responseArray = jsonObject;
        
        
        //NSArray* ytItemArray = [jsonObject objectForKey:@"data"];
        
        //NSDictionary* ytItemArray = [jsonObject objectForKey:@"data"];


        int ytItemCount = jsonObject.count;
        
        NSMutableArray* ytItemArray = [[NSMutableArray alloc] initWithCapacity:ytItemCount];
        
        //merchArray = [self buildArrayOfWebViews];
        
        ytItemArray = [self buildArrayOfWebViews:jsonObject];

        
        //[self.view addSubview:tmpUiWebView];
        
        for(UIWebView* tmpUIWV in ytItemArray){
            //[self.view addSubview:tmpUIWV];
            
            [scrollView addSubview:tmpUIWV];
        }
        

        
        //NSString *cvcCheck = [[jsonObject objectForKey:@"card"] objectForKey:@"cvc_check"];
        
        
        NSLog(@"youtube--response--->%@", operation.response);
        //NSLog(@"stripe--response status code--->%@", operation.response["@status code"]);
        NSLog(@"youtube--response object--->%@", jsonObject);
        NSLog(@"youtube--response string--->%@", operation.responseString);
        //NSLog(@"stripe--response array--->%@", responseArray);
       
        
        /*
        NSLog(@"stripe--response array::paid--->%@", paidStr);
        NSLog(@"stripe--response array::cvcCheck--->%@", cvcCheck);
        */
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject){
        
        //show Connect Failed UIAlertView
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"AFHTTPRequestOp FAILURE"
                                                         message:@"You're a failure.  Give up."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        
        [alert show];
        
        
        
    }];

    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
    
    
}

@end
