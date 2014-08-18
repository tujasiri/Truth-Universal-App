//
//  subController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 8/28/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

//#import "AppDelegate.h"
#import "MusicController.h"
#import "MBProgressHUD.h"

//@interface MusicController

@implementation MusicController


/*
 @synthesize btnClickMe;

-(IBAction)clicked:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil   message:@"Welcome" delegate:self cancelButtonTitle:@"Ok"       otherButtonTitles: nil];
    
    [alert show];
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Truth Universal on iTunes";
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    /*
     UIAlertView *loadView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here...viewDidLoad" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [loadView show];
     */
     
    
    NSURL *musicURL = [NSURL URLWithString:@"https://itunes.apple.com/lookup?id=126118972&entity=album"];
    
    //NSURL *musicURL = [NSURL URLWithString:@"http://echo.jsontest.com/key/one/key/two"];
    
    //NSLog([NSString stringWithFormat:@"%@",musicURL]);
    

    NSURLRequest *musicRequest = [NSURLRequest requestWithURL:musicURL];
    
    [[NSURLConnection alloc] initWithRequest:musicRequest delegate:self];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    /*
     UIAlertView *loadView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Response" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [loadView show];
     */
    
    albumData = [[NSMutableData alloc] init];
     

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    if(data == nil){
        //UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nilly." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        //[testView show];
    }
    else
        [albumData appendData:data];
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    

    NSError *errordesc;
    
    NSDictionary *musicObject = [NSJSONSerialization JSONObjectWithData:albumData options:nil error:&errordesc];
    
    
    if(!musicObject){
        NSLog(@"JSON Error==%@",errordesc);
    }
    
    albumArray = [musicObject objectForKey:@"results"];
    
    NSLog(@"jsonarray in connectionDidFinishLoading: %@", albumArray);



    [albumView reloadData];

}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
     UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Download could not complete.  Please make sure you are connected to 4G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];

    [errorView show];
     
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImage *myImage = [UIImage imageNamed:@"tu_app_header.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,300,100);
    
    return imageView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
*/


- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /*NSString* messageString = [NSString stringWithFormat: @"%d item(s) in musicArray", [musicArray count]];
    
    NSLog(@"jsonarray in numberOfRows: %@", musicArray);
*/

    NSString* messageString = [NSString stringWithFormat: @"%d item(s) in musicArray", [albumArray count]];
    
    /*
     UIAlertView *tblViewLoadMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:messageString delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [tblViewLoadMsg show];
     */
    
    
    return [albumArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
     /*
      UIAlertView *tblViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loaded tableView." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [tblViewMsg show];
      */
     
    
    //NSLog(@"jsonarray in tableView1: %@", musicArray);

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCellIdentifier"];
    
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MainCell"];
        
        NSLog(@"cell is nil");

        //cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MusicCellIdentifier"];
    
    }
    
    //cell.textLabel.text = [[musicArray objectAtIndex:indexPath.row] objectForKey:@"results"];
    
    /*
    cell.textLabel.text = [[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionName"];
    */
    
    
    //NSLog(@"jsonarray in tableView: %@", musicArray);

    
    //cell.textLabel.text = [musicArray objectForKey:@"trackName"];


    
    
     /*
      UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [testView show];
      */
    
    
    
    // Get the cell label using its tag and set it
    
    
     
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    
    
    NSString *cellText = [NSString stringWithFormat:@"%@",[[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionName"]];
    
    [cellLabel setText:cellText];
    
    NSLog(@"cellLabel == %@",[[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionName"]);
     
     
    
    //get image from URL
    
    
    NSString *albumImageUrl = [NSString stringWithFormat:@"%@",[[albumArray objectAtIndex:indexPath.row] objectForKey:@"artworkUrl100"]];
    
    NSLog(@"albumImageUrl == %@",albumImageUrl);
    
    NSURL * imageURL = [NSURL URLWithString:albumImageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    // get the cell imageview using its tag and set it
    UIImageView *cellImage = (UIImageView *)[cell viewWithTag:2];
    //[cellImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d .jpg", indexPath.row]]];
    
    [cellImage setImage:image];
    
    
    return cell;
}


// Do some customisation of our new view when a table item has been selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    /*
     NSString *segueMsg = [NSString stringWithFormat:@"segue ID is ==>%@, Album ID is %@",[segue identifier],albumID];
    
    UIAlertView *segView = [[UIAlertView alloc] initWithTitle:@"Test" message:segueMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [segView show];
     
     */
    
    // Make sure we're referring to the correct segue
    if ([[segue identifier] isEqualToString:@"MusicControllerSegue"]) {
        
        
        ITunesAlbumViewController *itunesAlbumViewController = [segue destinationViewController];

        
        itunesAlbumViewController.albumId = albumID;
        itunesAlbumViewController.title = albumTitle;

        
        
        

        
        // get the selected index
        //NSInteger selectedIndex = [[self. indexPathForSelectedRow] row];
        
        // Pass the name and index of our film
        //[vc setSelectedItem:[NSString stringWithFormat:@"%@", [myData objectAtIndex:selectedIndex]]];
        //[vc setSelectedIndex:selectedIndex];
        
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
    ITunesAlbumViewController *itunesAlbumViewController = [ITunesAlbumViewController alloc];
    
    itunesAlbumViewController.albumId = [[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionId"];
     */
    
    
    albumID = [[albumArray objectAtIndex:indexPath.row]objectForKey:@"collectionId"];
    
    albumTitle = [NSString stringWithFormat:@"Truth Universal::%@",[[albumArray objectAtIndex:indexPath.row]objectForKey:@"collectionName"]];
    
    /*
     if (self.navigationController == nil){
        UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nil Sun." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [testView show];
    }*/
    

    //[self.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
    
    
    //[vc.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
   /* UINavigationController *navCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicController"];
    
    [navCon pushViewController:itunesAlbumViewController animated:YES];*/
    

    
    [self performSegueWithIdentifier:@"MusicControllerSegue" sender:self];
    
    

}




@end

