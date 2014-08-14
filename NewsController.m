//
//  NewsController.m
//  Truth Universal App Beta
//
//  Created by tajiri ujasiri on 10/23/13.
//  Copyright (c) 2013 tajiri ujasiri. All rights reserved.
//

#import "NewsController.h"

@implementation NewsController

@synthesize newsArticleImage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Truth Universal News";
    self.view.backgroundColor = [UIColor blackColor];

    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *newsURL = [NSURL URLWithString:@"http://truthuniversal.com/news"];
    
    //NSURL *musicURL = [NSURL URLWithString:@"http://echo.jsontest.com/key/one/key/two"];
    
    //NSLog([NSString stringWithFormat:@"%@",musicURL]);
    
    
    NSURLRequest *newsRequest = [NSURLRequest requestWithURL:newsURL];

    [[NSURLConnection alloc] initWithRequest:newsRequest delegate:self];
    
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
    
    newsData = [[NSMutableData alloc] init];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    if(data == nil){
        UIAlertView *newsViewMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nilly." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        
        [newsViewMsg show];
    }
    else
        [newsData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    NSError *errordesc;
    
    NSDictionary *newsObject = [NSJSONSerialization JSONObjectWithData:newsData options:nil error:&errordesc];
    
    
    if(!newsObject){
        NSLog(@"JSON Error==%@",errordesc);
    }
    
    //newsArray = [newsObject objectForKey:@"title"];
    
    newsArray = newsObject;
    
    NSLog(@"jsonarray in connectionDidFinishLoading: %@", newsArray);
    
    
    [newsView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Download could not complete.  Please make sure you are connected to 4G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [errorView show];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
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

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /*NSString* messageString = [NSString stringWithFormat: @"%d item(s) in musicArray", [musicArray count]];
     
     NSLog(@"jsonarray in numberOfRows: %@", musicArray);
     */
    
    NSString* messageString = [NSString stringWithFormat: @"%d item(s) in newsArray", [newsArray count]];
    
    /*
     UIAlertView *tblViewLoadMsg = [[UIAlertView alloc] initWithTitle:@"Test" message:messageString delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [tblViewLoadMsg show];
     */
    
    
    return [newsArray count];
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
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"MainCell"];
        
        //cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MusicCellIdentifier"];
        
    }
    
    //cell.textLabel.text = [[musicArray objectAtIndex:indexPath.row] objectForKey:@"results"];
    
    
     cell.textLabel.text = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"news_title"];
    
    cell.detailTextLabel.text = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"news_subtitle"];
    
    
    //NSLog(@"jsonarray in tableView: %@", musicArray);
    
    
    //cell.textLabel.text = [newsArray objectForKey:@"title"];
    
    
    
    
    /*
     UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Here." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [testView show];
     */
    
    
    
    // Get the cell label using its tag and set it
    
    /*
    
    UILabel *newsCellLabel = (UILabel *)[cell viewWithTag:3];
    
    NSString *newsCellText = [NSString stringWithFormat:@"%@",[[newsArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    [newsCellLabel setText:newsCellText];
    
    NSLog(@"cellLabel == %@",[[newsArray objectAtIndex:indexPath.row] objectForKey:@"title"]);
    
    
    */
    
    //get image from URL
    
    /*  moved to didSelectRowAtIndexPath Method

    NSString *newsImageUrl = [NSString stringWithFormat:@"%@",[[newsArray objectAtIndex:indexPath.row] objectForKey:@"image_link"]];
    
    NSLog(@"newsImageUrl == %@",newsImageUrl);
    
    newsArticleLink = [NSURL URLWithString:newsImageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:newsArticleLink];
    
    newsArticleImage = [UIImage imageWithData:imageData];
    
    //newsArticleText = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"article"];
    
     NSLog(@"newsArtcleText ====> %@",newsArticleText);
    */
    
    /*
    // get the cell imageview using its tag and set it
    UIImageView *cellImage = (UIImageView *)[cell viewWithTag:2];
    //[cellImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d .jpg", indexPath.row]]];
    
    [cellImage setImage:image];
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
    if ([[segue identifier] isEqualToString:@"NewsDetailSegue"]) {
        
        
        NewsDetailController *newsDetailController = [segue destinationViewController];
        
        
         
         /*
         // get the cell imageview using its tag and set it
         UIImageView *cellImage = (UIImageView *)[cell viewWithTag:2];
         //[cellImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d .jpg", indexPath.row]]];
         
         [cellImage setImage:image];
         */
        
        newsDetailController.articleImage = newsArticleImage;
        newsDetailController.articleLink = newsArticleLink;
        newsDetailController.articleText = newsArticleText;
        
            
        
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
    
    
    //*** newsArticleImage = [[albumArray objectAtIndex:indexPath.row]objectForKey:@"collectionId"];
    
    //*** newsArticleLink = [NSString stringWithFormat:@"Truth Universal::%@",[[albumArray objectAtIndex:indexPath.row]objectForKey:@"collectionName"]];
    
    /*
     if (self.navigationController == nil){
     UIAlertView *testView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nil Sun." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
     
     [testView show];
     }*/
    
    
    //[self.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
    
    
    //[vc.navigationController pushViewController:itunesAlbumViewController animated:YES];
    
    /* UINavigationController *navCon = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicController"];
     
     [navCon pushViewController:itunesAlbumViewController animated:YES];*/
    
    NSString *newsImageUrl = [NSString stringWithFormat:@"%@",[[newsArray objectAtIndex:indexPath.row] objectForKey:@"news_image_link"]];
    
    NSLog(@"newsImageUrl == %@",newsImageUrl);
    
    NSURL * imageURL = [NSURL URLWithString:newsImageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
   
    
    newsArticleImage = [UIImage imageWithData:imageData];
    
    //newsArticleText = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"article"];
    
    
    
    newsArticleText = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"news_article"];
    
    NSLog(@"newsArtcleText ====> %@",newsArticleText);
    
    NSLog(@"HERE ****");
    
    newsArticleLink = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"news_external_link"];

    
    [self performSegueWithIdentifier:@"NewsDetailSegue" sender:self];
    
    
    
}





@end
