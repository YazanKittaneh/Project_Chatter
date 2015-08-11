//
//  LocalTableViewController.m
//  ParsePrototype
//
//  Created by Alex French on 6/14/15.
//  Copyright (c) 2015 french.chagrin. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalTableViewController.h"
#import <Parse/Parse.h>
#import "Date.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKShareKit/FBSDKShareKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LocalTableViewController ()
@property (nonatomic, strong) NSMutableDictionary *calendarTable;
@property (nonatomic, strong) NSMutableArray *currentDay;
@property (nonatomic, strong) NSArray *cronKeys;
@end

@implementation LocalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    PFQuery *query = [PFQuery queryWithClassName:@"event"];
    [query whereKey:@"Description" equalTo:@"greatest"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error){
            if (error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
                [alertView show];
            } else {
                self.calendarTable = [[NSMutableDictionary alloc] init];
                self.currentDay = [[NSMutableArray alloc] init];
                NSLog(@"%@", events);
                for (PFObject *event in events) {
                    NSLog(@"Test");
                    NSLog(@"%@", event[@"Time"]);
                    NSString *date = event[@"Time"];
                    
                    if (self.calendarTable[date]){
                        [self.calendarTable[date] addObject:event];
                    } else {
                        self.calendarTable[date] = [[NSMutableArray alloc] init];
                        [self.calendarTable[date] addObject:event];
                    }
                }
                
                NSArray *keys = [self.calendarTable allKeys];
                self.cronKeys =  [keys sortedArrayUsingComparator: ^(NSString *d1, NSString *d2) {
                    NSDate *date1 = [NSDate dateFromString:d1];
                    NSDate *date2 = [NSDate dateFromString:d2];
                    return [date1 compare:date2];
                }];
                NSLog(@"%@", self.cronKeys);
                NSLog(@"%@", keys);
                [self.tableView reloadData];
                self.tableView.scrollEnabled = YES;
            }
        }];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //PFUser *currentUser = [PFUser currentUser];
    //if (currentUser){
    //    NSLog(@"Username: %@", currentUser.username);
    //    [self _loadData];
    //} else {
    //    [self performSegueWithIdentifier:@"showLogin" sender:self];
    //}

}

/*- (void)_loadData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            
            // Run network request asynchronously
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     // Set the image in the imageView
                     // ...
                 }
             }];
        }
    }];
}*/

//- (void)viewWillAppear:(BOOL)animated {
//    if (![PFUser currentUser] || // Check if user is cached
//        ![PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) { // Check if user is linked to Facebook
//        PFLogInViewController *controller = [[PFLogInViewController alloc] init];
//        logInController.fields = (PFLogInFieldsUsernameAndPassword
//                                  | PFLogInFieldsFacebook
//                                  | PFLogInFieldsDismissButton);
//        [self presentViewController:controller animated:YES];
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.cronKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.calendarTable objectForKey:[self.cronKeys objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.cronKeys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"simpleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
    }
    
    NSString *dateKey =  self.cronKeys[indexPath.section];
    PFObject *event = self.calendarTable[dateKey][indexPath.row];
    
    cell.textLabel.text = event[@"Name"];
    return cell;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)logOut:(id)sender {
//    [PFUser logOut];
//    [self performSegueWithIdentifier:@"showLogin" sender:self];
//}

@end