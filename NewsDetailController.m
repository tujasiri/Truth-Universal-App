//
//  NewsDetailController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/26/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsView.h"

@interface NewsDetailController(){
}
@end

@implementation NewsDetailController

@synthesize articleText;
@synthesize articleLink;
@synthesize articleImage;

//- (void)loadView {
//    [super loadView];
    
- (void)viewDidLoad
    {
        [super viewDidLoad];
    
    
    NSLog(@"viewController articleText== %@",articleText);
    
    

    
    //self.view = [[ NewsView alloc] initWithFrame:self.view.bounds];
    
    ((NewsView*)self.view).nArticleText = articleText;
    ((NewsView*)self.view).nArticleImage = articleImage;

    
    //NewsView *nView =[[ NewsView alloc] init];
    
    self.view.frame = [[UIScreen mainScreen] bounds];

    //self.view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
        [backgroundImage setUserInteractionEnabled:NO];
        [self.view addSubview:backgroundImage];
        
        [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
        
        backgroundImage.alpha = .075;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
