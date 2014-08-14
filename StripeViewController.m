//
//  StripeViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 12/9/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "StripeViewController.h"
#import "Stripe.h"

#import "CheckoutCart.h"
#import "EmailManager.h"

#import "CheckoutInputCell.h"
#import "CheckoutDisplayCell.h"

#import "AFNetworking.h"
#import "AFURLSessionManager.h"


#define STRIPE_TEST_PUBLIC_KEY @"pk_test_Mbj6irUkfrtN8b5JXRYO8kOz"
#define STRIPE_TEST_POST_URL @"http://truthuniversal.com/ios/stripe-payment.php"

@interface StripeViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet UIView* buttonView;
@property (strong, nonatomic) IBOutlet UIButton* completeButton;

@property (strong, nonatomic) UITextField* nameTextField;
@property (strong, nonatomic) UITextField* emailTextField;
@property (strong, nonatomic) UITextField* expirationDateTextField;
@property (strong, nonatomic) UITextField* cardNumber;
@property (strong, nonatomic) UITextField* CVCNumber;

@property (strong, nonatomic) UITextField* addressTextField;
@property (strong, nonatomic) UITextField* cityTextField;
@property (strong, nonatomic) UITextField* stateTextField;

@property (strong, nonatomic) UITextField* zipTextField;

@property (strong, nonatomic) UITextField* countryTextField;


@property (strong, nonatomic) NSMutableArray* countryArray;
@property (strong, nonatomic) NSString* selectedCountry;



@property (strong, nonatomic) NSArray* monthArray;
@property (strong, nonatomic) NSNumber* selectedMonth;
@property (strong, nonatomic) NSNumber* selectedYear;
@property (strong, nonatomic) UIPickerView *expirationDatePicker;
@property (strong, nonatomic) UIPickerView *countryPicker;


@property (strong, nonatomic) STPCard* stripeCard;

- (IBAction)completeButtonTapped:(id)sender;


//@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;



@end

@implementation StripeViewController



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
    
    self.title=@"Checkout::Customer Info";
    
    
    //self.view.backgroundColor = [UIColor blackColor];
    
    self.monthArray = @[@"01 - January", @"02 - February", @"03 - March",
                        @"04 - April", @"05 - May", @"06 - June", @"07 - July", @"08 - August", @"09 - September",
                        @"10 - October", @"11 - November", @"12 - December"];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArrayTMP = [NSLocale ISOCountryCodes];
    
    //NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
   self.countryArray = [[NSMutableArray alloc] init];

    
    for (NSString *countryCode in countryArrayTMP) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        
        NSLog(@"country code ==>%@ :: country name==>%@",countryCode, displayNameString);
        
        [self.countryArray addObject:displayNameString];
        
    }
    
    
    [self.countryArray sortUsingSelector:@selector(localizedCompare:)];
    
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

#pragma mark - Stripe

- (IBAction)completeButtonTapped:(id)sender {
    //1
    
    
    self.stripeCard = [[STPCard alloc] init];
    self.stripeCard.name = self.nameTextField.text;
    self.stripeCard.number = self.cardNumber.text;
    self.stripeCard.cvc = self.CVCNumber.text;
    self.stripeCard.expMonth = [self.selectedMonth integerValue];
    self.stripeCard.expYear = [self.selectedYear integerValue];
    self.stripeCard.addressLine1 = self.addressTextField.text;
    self.stripeCard.addressCountry = self.countryTextField.text;
    self.stripeCard.addressCity = self.cityTextField.text;
    self.stripeCard.addressState = self.stateTextField.text;
    self.stripeCard.addressZip = self.zipTextField.text;

    
    
    //2
    if ([self validateCustomerInfo]) {
        [self performStripeOperation];
    }
}

- (BOOL)validateCustomerInfo {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                     message:@"Please enter all required information"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    //1. Validate name & email
    if (self.nameTextField.text.length == 0 ||
        self.emailTextField.text.length == 0) {
        
        [alert show];
        return NO;
    }
    
    //2. Validate card number, CVC, expMonth, expYear
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    //3
    if (error) {
        alert.message = [error localizedDescription];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (void)performStripeOperation {
    //1
    self.completeButton.enabled = NO;
    
    //2
    /*
     [Stripe createTokenWithCard:self.stripeCard
     publishableKey:STRIPE_TEST_PUBLIC_KEY
     success:^(STPToken* token) {
     [self postStripeToken:token.tokenId];
     } error:^(NSError* error) {
     [self handleStripeError:error];
     }];
     */
    [Stripe createTokenWithCard:self.stripeCard
                 publishableKey:STRIPE_TEST_PUBLIC_KEY
                     completion:^(STPToken* token, NSError* error) {
                         if(error)
                             [self handleStripeError:error];
                         else
                             [self postStripeToken:token.tokenId];
                     }];

}

- (void)postStripeToken:(NSString* )token {
    //1
    //NSURL *postURL = [NSURL URLWithString:STRIPE_TEST_POST_URL];
    
    
    
    //AFHTTPClient* httpClient = [AFHTTPClient clientWithBaseURL:postURL];
    
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:postURL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:nil];
    [operation start];
     */


/*
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
*/
    
    //2
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    NSInteger totalCents = [[checkoutCart total] doubleValue] * 100;
    
    //3
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"stripeAmount"] = [NSString stringWithFormat:@"%d", totalCents];
    postRequestDictionary[@"stripeCurrency"] = @"usd";
    postRequestDictionary[@"stripeCard"] = token;
    //postRequestDictionary[@"stripeToken"] = token;

    postRequestDictionary[@"stripeDescription"] = @"Purchase from Truth Universal Merch Store!";
    
    //postRequestDictionary[@"stripeCard"] = self.stripeCard.number;
    
    /*
    postRequestDictionary[@"stripeToken"] = token;
    postRequestDictionary[@"stripeToken"] = token;
    postRequestDictionary[@"stripeToken"] = token;
    postRequestDictionary[@"stripeToken"] = token;

*/
    
    
    //NSLog(@"stripe card no%@",self.stripeCard.number);
    
    
    //new AFNeworking Request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    [manager POST:STRIPE_TEST_POST_URL parameters:postRequestDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
        NSDictionary* jsonObject = [NSJSONSerialization
                         JSONObjectWithData:operation.responseData
                                    options:kNilOptions
                         error:nil];
        
        //NSArray *responseArray = jsonObject;
        
        
        NSString *paidStr = [jsonObject objectForKey:@"paid"];
        NSString *cvcCheck = [[jsonObject objectForKey:@"card"] objectForKey:@"cvc_check"];
        

        /*
        NSArray *deserializedArray = nil;
        
        if (jsonObject != nil) {
            if ([jsonObject isKindOfClass:[NSArray class]])     {         //Convert the NSData to NSArray in this final step         deserializedArray = (NSDictionary *)jsonObject;
            } 
        }
        
        NSError *e;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&e];
        
        [NSLog(@"error==%@",e);
         */
        
        //NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
        
        NSLog(@"stripe--response--->%@", operation.response);
        //NSLog(@"stripe--response status code--->%@", operation.response["@status code"]);
        NSLog(@"stripe--response object--->%@", jsonObject);
        NSLog(@"stripe--response string--->%@", operation.responseString);
        //NSLog(@"stripe--response array--->%@", responseArray);
        
        NSLog(@"stripe--response array::paid--->%@", paidStr);
        NSLog(@"stripe--response array::cvcCheck--->%@", cvcCheck);



        [self chargeDidSucceed];
    
        
        
        //NSLog(@"stripe--response string--->%@", operation.responseString);
        
        

        
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self chargeDidNotSucceed];

    
    
    }
     
     
     
        ];
    
    //4
    /*
    NSMutableURLRequest* request = [httpClient requestWithMethod:@"POST" path:nil parameters:postRequestDictionary];
    
    self.httpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self chargeDidSucceed];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self chargeDidNotSuceed];
    }];
    
    [self.httpOperation start];
     */
    
    
    self.completeButton.enabled = YES;
}

- (void)handleStripeError:(NSError *) error {
    //Implement
}

- (void)chargeDidSucceed {
    UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Thank you for shopping with Truth Universal Music, LLC"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alertSuccess show];
    
    //Send confirmation email
    EmailManager* emailManager = [[EmailManager alloc] initWithRecipient:self.nameTextField.text
                                                          recipientEmail:self.emailTextField.text
                                                        recipientAddress:self.addressTextField.text
                                                           recipientCity:self.cityTextField.text
                                                          recipientState:self.stateTextField.text
                                                        recipientCountry:self.countryTextField.text
                                                            recipientZip:self.zipTextField.text];
    
    [emailManager sendConfirmationEmail];
    
    CheckoutCart* checkoutCart = [CheckoutCart sharedInstance];
    [checkoutCart clearCart];
    
    NSString *itmCt = [NSString stringWithFormat:@"%lu",(unsigned long)[CheckoutCart sharedInstance].itemsInCart.count];
    
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:2] setBadgeValue:itmCt ];
    
    [self.navigationController popToRootViewControllerAnimated:YES];}

- (void)chargeDidNotSucceed {
    UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@"Transaction Failed"
                                                    message:@"The transaction could not be processed.  Please try again later."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alertFailure show];
}


/* The methods below implement the user interface. You don't need to change anything. */

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; // (1) user details, (2) credit card details
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return (section == 0) ? @"Customer Info" : @"Credit Card Details";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 7 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    //CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
    CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];


    
    if (cell == nil){
        NSLog(@"cell is nil");
        cell = [[CheckoutInputCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CheckoutInputCell"];
        
    }
     
    
    if (section == 0 && row == 0) {
        //CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];

        cell.nameLabel.text = @"Name";
        cell.textField.placeholder = @"Required";
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        self.nameTextField = cell.textField;
        return cell;
    }
    else if (section == 0 && row == 1) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"E-mail";
        cell.textField.placeholder = @"Required";
        self.emailTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        return cell;
    }
    else if (section == 0 && row == 2) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"Street Address";
        cell.textField.placeholder = @"Required";
        self.addressTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        return cell;
    }
    else if (section == 0 && row == 3) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"City";
        cell.textField.placeholder = @"Required";
        self.cityTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        return cell;
    }
    else if (section == 0 && row == 4) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"State";
        cell.textField.placeholder = @"Required";
        self.stateTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        return cell;
    }
    else if (section == 0 && row == 5) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"Zip/Country Code";
        cell.textField.placeholder = @"Required";
        self.zipTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        return cell;
    }
    else if (section == 0 && row == 6) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"Country";
        cell.textField.placeholder = @"United States";
        self.countryTextField = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeAlphabet;
        [self configureCountryPickerView];

        return cell;
    }
    
    else if (section == 1 && row == 0) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"Card Number";
        cell.textField.placeholder = @"Required";
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.cardNumber = cell.textField;
        return cell;
    }
    else if (section == 1 && row == 1) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"Exp. Date";
        cell.textField.text = @"Required";
        cell.textField.textColor = [UIColor lightGrayColor];
        self.expirationDateTextField = cell.textField;
        return cell;
    }
    else if (section == 1 && row == 2) {
        CheckoutInputCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CheckoutInputCell"];
        cell.nameLabel.text = @"CVC Number";
        cell.textField.placeholder = @"Required";
        self.CVCNumber = cell.textField;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self configurePickerView];
        return cell;
    }
    
    //return cell;
    
    return nil;

}

/*

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImage *myImage = [UIImage imageNamed:@"tu_app_header.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,300,100);
    
    if(section==0)
        return imageView;
    
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return 70;
    
    return 0;
}
 */

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIPicker data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSLog(@"description of uipickerView in numberOfCoponents ==> %@",pickerView);
    
    if(pickerView == self.countryPicker){
        NSLog(@"it's the country picker!");
        return 1;
    }
    
    return 2;
    
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSLog(@"pickerView.tag in numberOfRowsInComponent==>%d",pickerView.tag);
    
    if(pickerView == self.countryPicker){
        return self.countryArray.count;
    }
    

    return (component == 0) ? 12 : 10;
}

#pragma mark - UIPicker delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSLog(@"pickerView.tag in titleForRow==>%d",pickerView.tag);
    
    if(pickerView == self.countryPicker){
        return self.countryArray[row];
    }
    
    else{
    
    if (component == 0) {
        //Expiration month
        return self.monthArray[row];
    }
    else {
        //Expiration year
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger currentYear = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
        return [NSString stringWithFormat:@"%i", currentYear + row];
    }
    }//end else
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"pickerView.tag in didSelect==>%d",pickerView.tag);

    if(pickerView == self.countryPicker){
        //self.selectedCountry = @"US";
        
        //[self.countryPicker selectRow:0 inComponent:0 animated:YES];

        //[self pickerView:self.countryPicker titleForRow:row forComponent:0];
        self.countryTextField.text = [self pickerView:self.countryPicker titleForRow:row forComponent:0];
    }
    
    else{
    
    if (component == 0) {
        self.selectedMonth = @(row + 1);
    }
    else {
        NSString *yearString = [self pickerView:self.expirationDatePicker titleForRow:row forComponent:1];
        self.selectedYear = @([yearString integerValue]);
    }
    
    
    if (!self.selectedMonth) {
        [self.expirationDatePicker selectRow:0 inComponent:0 animated:YES];
        self.selectedMonth = @(1); //Default to January if no selection
    }
    
    if (!self.selectedYear) {
        [self.expirationDatePicker selectRow:0 inComponent:1 animated:YES];
        NSString *yearString = [self pickerView:self.expirationDatePicker titleForRow:0 forComponent:1];
        self.selectedYear = @([yearString integerValue]); //Default to current year if no selection
    }
    
    self.expirationDateTextField.text = [NSString stringWithFormat:@"%@/%@", self.selectedMonth, self.selectedYear];
    self.expirationDateTextField.textColor = [UIColor blackColor];
    }//end else
}

#pragma mark - UIPicker configuration

- (void)configurePickerView {
    
    

    
    self.expirationDatePicker = [[UIPickerView alloc] init];
    self.expirationDatePicker.delegate = self;
    self.expirationDatePicker.dataSource = self;
    self.expirationDatePicker.showsSelectionIndicator = YES;
    
    
    
    //Create and configure toolabr that holds "Done button"
    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(pickerDoneButtonPressed)];
    
    [pickerToolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    
    self.expirationDateTextField.inputView = self.expirationDatePicker;
    self.expirationDateTextField.inputAccessoryView = pickerToolbar;
    self.nameTextField.inputAccessoryView = pickerToolbar;
    self.emailTextField.inputAccessoryView = pickerToolbar;
    self.cardNumber.inputAccessoryView = pickerToolbar;
    self.CVCNumber.inputAccessoryView = pickerToolbar;
    
    
}

- (void)configureCountryPickerView {
    //configure countryPicker
    self.countryPicker.tag = 1;
    
    self.countryPicker = [[UIPickerView alloc] init];
    self.countryPicker.delegate = self;
    self.countryPicker.dataSource = self;
    self.countryPicker.showsSelectionIndicator = YES;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(pickerDoneButtonPressed)];
    
    [pickerToolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    //further countryPicker config
    self.countryTextField.inputView = self.countryPicker;
    self.countryTextField.inputAccessoryView = pickerToolbar;
}

- (void)pickerDoneButtonPressed {
    [self.view endEditing:YES];
}

@end
