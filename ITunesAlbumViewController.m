//
//  ITunesAlbumViewController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 9/4/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "ITunesAlbumViewController.h"

/*@interface ITunesAlbumViewController()

@end*/

@implementation ITunesAlbumViewController

 
@synthesize albumId;

-(void)viewDidAppear:(BOOL)animated {
    
    
    
    [HUD hide:YES];
    
    //[super viewDidAppear:];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view.superview];
    [self.navigationController.view.superview addSubview:HUD];
    [HUD show:YES];
    
    
    

    //self.title=@"Truth Universal on iTunes";
    
    /*
     UIAlertView *tblViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loaded tableView." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [tblViewMsg show];
     */
    
    
    
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    
    /*
     UIAlertView *loadView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [loadView show];
     */
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@&entity=song",albumId];
    
    
    NSLog([NSString stringWithFormat:@"album Id is %@",albumId]);
    
    //NSURL *albumURL = [NSURL URLWithString:@"https://itunes.apple.com/lookup?id=126118972&entity=album"];
    
    NSURL *albumURL = [NSURL URLWithString:urlString];

    
    //NSURL *musicURL = [NSURL URLWithString:@"http://echo.jsontest.com/key/one/key/two"];
    
    
    NSURLRequest *albumRequest = [NSURLRequest requestWithURL:albumURL];
    
    [[NSURLConnection alloc] initWithRequest:albumRequest delegate:self];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu_encircled.png"]];
    [backgroundImage setUserInteractionEnabled:NO];
    [self.view addSubview:backgroundImage];
    
    [backgroundImage setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds]))];
    
    backgroundImage.alpha = .075;
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    albumDataFull = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [albumDataFull appendData:data];
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSDictionary *musicObject = [NSJSONSerialization JSONObjectWithData:albumDataFull options:nil error:nil];
    
    
    
    //NSLog(@"jsonsobject: %@", musicObject);
    
    
    
    
    songArray = [musicObject objectForKey:@"results"];
    
    //NSLog(@"musicObject: %@", musicObject);

    
    NSLog(@"songarray: %@", songArray);
    
    //NSLog(@"jsonitem--amgArtistId: %@", [musicArray objectForKey:@"amgArtistId"]);
    
    
    [songsView reloadData];
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
     UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Download could not complete.  Please make sure you are connected to 4G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [errorView show];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString* messageString = [NSString stringWithFormat: @"%d item(s) in songArray", [songArray count]];
     
     /*
      
      UIAlertView *tblViewLoadMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:messageString delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [tblViewLoadMsg show];
      
      */
    

    
    
    return [songArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     UIAlertView *tblViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here--loaded tableView." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [tblViewMsg show];
     */
    
    NSLog(@"jsonarray in tableView1: %@", songArray);
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellSongs"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MainCellSongs"];
        
    }
    
    //cell.textLabel.text = [[musicArray objectAtIndex:indexPath.row] objectForKey:@"results"];
    
    cell.textLabel.text = [[songArray objectAtIndex:indexPath.row] objectForKey:@"trackName"];
    
    //NSLog(@"jsonarray in tableView: %@", musicArray);
    
    
    //cell.textLabel.text = [musicArray objectForKey:@"trackName"];
    
    
    
    /*
     UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [testView show];
     */
    
    
    
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
    if ([[segue identifier] isEqualToString:@"ModalSongSegue"]) {
        
        
        //ITunesAlbumViewController *itunesAlbumViewController = [segue destinationViewController];
        
        ITunesSongViewController *itunesSongViewController = [segue destinationViewController];

        
        itunesSongViewController.songUrl = albumViewSongUrl;
        
        itunesSongViewController.songName = albumViewSongName;
        
        
        /*
         NSString *segueMsg = [NSString stringWithFormat:@"segue ID is ==>%@, albumViewSongUrl is %@",[segue identifier],albumViewSongUrl];
        
        UIAlertView *segView = [[UIAlertView alloc] initWithTitle:@"Test" message:segueMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [segView show];
         */
        
        
        
        // get the selected index
        //NSInteger selectedIndex = [[self. indexPathForSelectedRow] row];
        
        // Pass the name and index of our film
        //[vc setSelectedItem:[NSString stringWithFormat:@"%@", [myData objectAtIndex:selectedIndex]]];
        //[vc setSelectedIndex:selectedIndex];
        
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     ITunesAlbumViewController *itunesAlbumViewController = [ITunesAlbumViewController alloc];
     
     itunesAlbumViewController.albumId = [[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionId"];
     */
    
    
    
    
    NSString *previewStr = [NSString stringWithFormat:@"%@",[[songArray objectAtIndex:indexPath.row]objectForKey:@"trackViewUrl"]];
    
    //NSLog(@"previewStr==%@",previewStr);
    
    //NSString *itunesStoreStr = [NSString stringWithFormat:@"%@",[previewStr stringByReplacingOccurrencesOfString:@"https" withString:@"https"]];
    
    //NSURL *itunesStoreURL = [NSURL URLWithString:itunesStoreStr];
    
     NSURL *itunesStoreURL = [NSURL URLWithString:previewStr];
    
    /*
    itunesSongViewController.songUrl = itunesStoreURL;
    itunesSongViewController.songName = [NSString stringWithFormat:@"%@",[[songArray objectAtIndex:indexPath.row]objectForKey:@"trackName"]];
     */

    
    albumViewSongUrl = itunesStoreURL;
    albumViewSongName = [NSString stringWithFormat:@"%@",[[songArray objectAtIndex:indexPath.row]objectForKey:@"trackName"]];
    
    //NSURL *previewUrl = [NSString stringWithFormat:@"%@",previewStr];

    //NSLog(itunesStoreStr);
    
    
    //[[UIApplication sharedApplication] openURL:itunesStoreURL];
    
    /*
     if (self.navigationController == nil){
     UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nil Sun." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [testView show];
     }*/
    
    
    //[self.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
    
    
    //[vc.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
    /* UINavigationController *navCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicController"];
     
     [navCon pushViewController:itunesAlbumViewController animated:YES];*/
    
    
    
    [self performSegueWithIdentifier:@"ModalSongSegue" sender:self];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ITunesAlbumViewController *itunesAlbumViewController = [ITunesAlbumViewController alloc];
    
    itunesAlbumViewController.albumId = [[albumArray objectAtIndex:indexPath.row] objectForKey:@"collectionId"];
    
    [self.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
}
*/








@end
