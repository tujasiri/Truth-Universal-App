//
//  MerchItemViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/1/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "MerchItemViewController.h"
#import "CheckoutCart.h"


@interface MerchItemViewController ()

@property (strong, nonatomic) IBOutlet UILabel *merchItemShortDescLabel;
@property (strong, nonatomic) IBOutlet UIImageView *merchItemImageView;
@property (strong, nonatomic) IBOutlet UILabel *merchItemLongDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *merchItemTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *merchItemPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;

- (IBAction)addToCartButtonTapped:(id)sender;

@end

@implementation MerchItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self loadData];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    self.addToCartButton.selected = [checkoutCart containsMerchItem:self.merchitem ] ? YES : NO;
}

- (void)loadData {
    
    self.merchItemShortDescLabel.text = self.merchitem.itemName;
    
    NSString* imageURLString = [NSString stringWithFormat:@"https://www.2checkout.com/va/public/render_image?image_id=%@",self.merchitem.imageId];
    
    NSURL* imageURL = [NSURL URLWithString:imageURLString];
    
    //NSURL * imageURL = [NSURL URLWithString:albumImageUrl];
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    
    UIImage * image = [UIImage imageWithData:imageData];
    
    [self.merchItemImageView setImage:image];
    
    self.merchItemLongDescLabel.text = [NSString stringWithFormat:@"Description: %@", self.merchitem.longDesc];
    
    self.merchItemTypeLabel.text = [NSString stringWithFormat:@"Item Type: %@", self.merchitem.itemType];
   
    self.merchItemPriceLabel.text = [NSString stringWithFormat:@"Price: $%@", self.merchitem.itemPrice];
}

- (IBAction)addToCartButtonTapped:(id)sender {
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    
    NSLog(@"Merch item view controller");
    
    if (!self.addToCartButton.selected) {
        [checkoutCart addMerchItem:self.merchitem];
        self.addToCartButton.selected = YES;
        
        NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
        
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:2] setBadgeValue:itmCt ];
    }
    else {
        [checkoutCart removeMerchItem:self.merchitem];
        self.addToCartButton.selected = NO;
    }
}

@end

