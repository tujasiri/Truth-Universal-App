//
//  ITunesSongViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 9/10/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "ITunesSongViewController.h"

@implementation ITunesSongViewController

@synthesize songUrl;
@synthesize songName;
@synthesize songWebView;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    NSLog(@"Load Started...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Load Done...");

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Load Failed...%@",error);


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=songName;
    
    NSString *msg = [NSString stringWithFormat:@"songUrl == %@",self.songUrl];
    
     UIAlertView *tblViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:msg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [tblViewMsg show];
    
    //NSURL *testurl = [NSURL URLWithString:@"http://a786.phobos.apple.com/us/r1000/116/Music/v4/84/5a/c4/845ac4bc-718b-2e39-bad6-2fcb4eff4ec8/mzaf_3028136743413109482.aac.m4a"];
    
    
    
    //[[UIApplication sharedApplication] openURL:songUrl];
    //NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:songUrl]];
    
    NSLog(@"songUrl == %@",songUrl);

    
    NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:songUrl];
    //NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:testurl];



    [songWebView loadRequest:theRequest];
    
    [self.view addSubview:songWebView];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;


}

-(void) viewDidAppear:(BOOL)animated {
    //[ songWebView loadRequest:[NSURLRequest requestWithURL:songUrl]];
}


@end
