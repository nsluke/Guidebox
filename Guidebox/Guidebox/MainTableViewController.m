//
//  MainTableViewController.m
//  Guidebox
//
//  Created by Luke Solomon on 10/8/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "MainTableViewController.h"
#import "CustomTableViewCell.h"
#import "NetworkCommunication.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface MainTableViewController ()
@end

@implementation MainTableViewController {
    NSArray *temporaryArray;
    NSDictionary *temporaryDictionary;
    
    NSDictionary *mixset;
    NSDictionary *currentMix;
    NSDictionary *imageURLs;
    
    NSString *coverImageURL;
    NSMutableArray *fetchedImageArray;
}

@synthesize mixArray;
//@synthesize fetchedImageArray;

-(void)viewDidLoad {
    [super viewDidLoad];

    //AFNetworking asynchronous url request
    
    
    [self getRequestToAPI];
    
    fetchedImageArray = [[NSMutableArray alloc]init];

}


#pragma mark - Network Requests
- (void)getRequestToAPI {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://8tracks.com/mix_sets/staff-picks.json?api_version=3&api_key=a77367ded6d762442d5f2076c42ea0df117d7992&include=mixes[lukesolomon]+pagination" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        //        temporaryDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        temporaryDictionary = responseObject;
        temporaryArray = [responseObject allValues];
        
        mixset = [temporaryDictionary objectForKey:@"mix_set"];
        mixArray = [mixset objectForKey:@"mixes"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mixArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    currentMix = [mixArray objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];
    NSDictionary *URLDictionary = [NSDictionary dictionaryWithDictionary:[[mixArray objectAtIndex:indexPath.row] objectForKey:@"cover_urls"]];
    
    NSString *urlForImage = [URLDictionary objectForKey:@"cropped_imgix_url"];

    NSString *cellTitleString = [currentMix objectForKey:@"name"];

    cell.cellTitle = cellTitleString;
    cell.cellDetails = [currentMix objectForKey:@"description"];

    [cell setCellImage:urlForImage];

    return cell;
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ViewController *destinationController = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    destinationController.title = [NSString stringWithFormat:@"%@",[[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"name"]];
    
    destinationController.description = [NSString stringWithFormat:@"%@",[[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"description"]];
    
    destinationController.imageURL = [[[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"cover_urls"] objectForKey:@"cropped_imgix_url"];
    
}

- (IBAction)unwindToTableView:(UIStoryboardSegue *)unwindSegue {
    
}

@end