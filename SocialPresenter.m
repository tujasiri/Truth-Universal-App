//
//  SocialPresenter.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 2/10/14.
//  Copyright (c) 2014 tajiri ujasiri. All rights reserved.
//

#import "SocialPresenter.h"

@implementation SocialPresenter

@synthesize socialWebView;

-(void)viewDidLoad{

    [super viewDidLoad];
    
    self.socialWebView.delegate=self;
    
    [self.view addSubview:socialWebView];
}

@end
