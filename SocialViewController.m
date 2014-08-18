//
//  SocialViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 11/24/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "SocialViewController.h"
#import "CJMTwitterFollowButton.h"
#import "FacebookLike.h"
#import "SocialPresenter.h"


@interface SocialViewController ()



@end



@implementation SocialViewController

@synthesize socialWebViewLocal;

-(UIWebView*)createSocialWebview :(NSString*)socialLink {
    //UIWebView *youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,320,320)];
    
    UIWebView *socialWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    socialWebView.allowsInlineMediaPlayback=YES;
    socialWebView.mediaPlaybackRequiresUserAction=NO;
    socialWebView.mediaPlaybackAllowsAirPlay=YES;
    socialWebView.delegate=self;
    socialWebView.scrollView.bounces=NO;
    
    
    
    //NSString *linkObj=@"http://www.youtube.com/v/X1yJhIZA1wI";//@"http://www.youtube.com/v/6MaSTM769Gk";
    NSLog(@"socialLink_________________%@",socialLink);
    /*
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    .youtube {\
    margin-left:auto;margin-right:auto;display:block;width:420;text-align:center;text-color:white;}\
    body {\
    background-color:#ededed;color:white}\\</style>\\</head><body style=\"margin:0\">\\<div class=\"youtube\">\\<embed  webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"420\" height=\"320\"></embed>\\<p class=\"youtube\" style=\"color:black;\">Title: %@</p><div></body></html>";
    */
    
   //NSString *html = [NSString stringWithFormat:embedHTML, vidLink, vidTitle];
    
    NSURL *url = [NSURL URLWithString:socialLink];

    
    NSLog(@"url ==> %@",url);
    
    //load site
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [socialWebView loadRequest:requestObj];

    return socialWebView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController* tmpvc = [[UIViewController alloc] init];
    
    tmpvc = self;
    
    self.title=@"Social Networks & Communication";
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    // Make sure we're referring to the correct segue
    if ([[segue identifier] isEqualToString:@"SocialViewControllerTwitterSegue"]){
        
        self.socialWebViewLocal = [self createSocialWebview:@"http://mobile.twitter.com/truthuniversal"];

        
        
        SocialPresenter *socialPresenter = [segue destinationViewController];
        
        
        socialPresenter.socialWebView = self.socialWebViewLocal;
        
        [socialPresenter.view addSubview:socialPresenter.socialWebView];

        
        
    }
    
    // Make sure we're referring to the correct segue
    if([[segue identifier] isEqualToString:@"SocialViewControllerFBSegue"]){
        
        self.socialWebViewLocal = [self createSocialWebview:@"http://m.facebook.com/truthuniversal"];

        
        SocialPresenter *socialPresenter = [segue destinationViewController];
        
        
        socialPresenter.socialWebView = self.socialWebViewLocal;
        
        [socialPresenter.view addSubview:socialPresenter.socialWebView];
        
        
    }

    
    /*
    
    if ([[segue identifier] isEqualToString:@"SocialViewControllerTwitterSegue"]) {
        
        
        SocialPresenter *socialPresenter = [segue destinationViewController];
        
        
        socialPresenter.socialWebView = self.socialWebViewLocal;
        
        [socialPresenter.view addSubview:socialPresenter.socialWebView];
        
        
        
        // get the selected index
        //NSInteger selectedIndex = [[self. indexPathForSelectedRow] row];
        
        // Pass the name and index of our film
        //[vc setSelectedItem:[NSString stringWithFormat:@"%@", [myData objectAtIndex:selectedIndex]]];
        //[vc setSelectedIndex:selectedIndex];
        
        
    }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
