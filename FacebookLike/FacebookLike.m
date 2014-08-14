//
//  FacebookLike.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 2/10/14.
//  Copyright (c) 2014 tajiri ujasiri. All rights reserved.
//

#import "FacebookLike.h"
#import "SocialPresenter.h"

@implementation FacebookLike


- (instancetype)initWithOrigin:(CGPoint)origin
                facebookAccount:(NSString *)facebookAccount
                       andSize:(FBTwitterFollowButtonSize)size
                      parentVC:(UIViewController*)pvc{
    
    CGRect frame = CGRectMake(origin.x, origin.y, 1, 1);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.facebookAccount = facebookAccount;
        self.buttonSize     = size;
        
        [self addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@synthesize socialWebViewLocal;

-(UIWebView*)createSocialWebview :(NSString*)socialLink {
    //UIWebView *youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,320,320)];
    
    UIWebView *socialWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,420,420)];
    
    socialWebView.allowsInlineMediaPlayback=YES;
    socialWebView.mediaPlaybackRequiresUserAction=NO;
    socialWebView.mediaPlaybackAllowsAirPlay=YES;
    //socialWebView.delegate=self;
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




- (void)buttonTapped {
    NSArray *urls = [NSArray arrayWithObjects:
                     /*
                     @"twitter://user?screen_name={handle}", // Twitter
                     @"tweetbot:///user_profile/{handle}", // TweetBot
                     @"echofon:///user_timeline?{handle}", // Echofon
                     @"twit:///user?screen_name={handle}", // Twittelator Pro
                     @"x-seesmic://twitter_profile?twitter_screen_name={handle}", // Seesmic
                     @"x-birdfeed://user?screen_name={handle}", // Birdfeed
                     @"tweetings:///user?screen_name={handle}", // Tweetings
                     @"simplytweet:?link=http://twitter.com/{handle}", // SimplyTweet
                     @"icebird://user?screen_name={handle}", // IceBird
                     @"fluttr://user/{handle}", // Fluttr
                      */
                     @"https://m.facebook.com/{handle}",
                     nil];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    NSString* urlAsString;
    
    for (NSString *candidate in urls) {
        NSURL *url = [NSURL URLWithString:[candidate stringByReplacingOccurrencesOfString:@"{handle}" withString:self.facebookAccount]];
        
        urlAsString = [NSString stringWithString:[candidate stringByReplacingOccurrencesOfString:@"{handle}" withString:self.facebookAccount]];
        
        NSLog(@"url ==> %@",url);
        
        if ([application canOpenURL:url]) {
            //[application openURL:url];
            
            
            socialWebViewLocal = [self createSocialWebview:urlAsString];
            
             //[pvc performseg: @"SocialViewControllerSegue"];
            
            NSLog(@"pvc title ==>%@", self.pvc.title);;
            
            //NSLog(@"%@",self.pvc.);
            
            [self.pvc performSegueWithIdentifier:@"SocialViewControllerSegue" sender:self];
            
            NSLog(@"DELA ON THE BOX!");
        
            // Stop trying after the first URL that succeeds
            //return;
        }
    }
}


- (void)setButtonSize:(FBTwitterFollowButtonSize)size {
    
    // Set the iVar
    _buttonSize = size;
    
    // Process it
    CGSize sizeForButtonFrame;
    
    if (self.buttonSize == FBButtonSizeSmall) {
        sizeForButtonFrame = CGSizeMake(61, 20);
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else {
        sizeForButtonFrame = CGSizeMake(122, 40);
        [self setBackgroundImage:[UIImage imageNamed:@"facebook_like_button_medium.jpg"] forState:UIControlStateNormal];
    }
    
    CGRect buttonFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeForButtonFrame.width, sizeForButtonFrame.height);
    [self setFrame:buttonFrame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    if(self) {
        self.buttonSize     = FBButtonSizeLarge;
        
        // Don't overwrite twitter account if it was set by a runtime attribute
        if (!self.facebookAccount) {
            self.facebookAccount = @"not-configured";
        }
        
        [self addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"facebookAccount"]) {
        self.facebookAccount = value;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure we're referring to the correct segue
    if ([[segue identifier] isEqualToString:@"SocialViewControllerSegue"]) {
        
        
        SocialPresenter *socialPresenter = [segue destinationViewController];
        
        
        socialPresenter.socialWebView = self.socialWebViewLocal;
        
        NSLog(@"HELLO DOLLY!");
        
    }
}


@end


