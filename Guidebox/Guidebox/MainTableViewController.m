//
//  MainTableViewController.m
//  Guidebox
//
//  Created by Luke Solomon on 10/8/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "MainTableViewController.h"
#import "CustomTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface MainTableViewController ()
@end

@implementation MainTableViewController {
    NSDictionary *mixset;
    NSDictionary *currentMix;
    NSDictionary *imageURLs;
    
    NSString *coverImageURL;
    NSMutableArray *fetchedImageArray;
    
    NSArray *mixArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self getRequestToAPI];
    fetchedImageArray = [[NSMutableArray alloc]init];
}

#pragma mark - Network Requests
- (void)getRequestToAPI {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://8tracks.com/mix_sets/staff-picks.json?api_version=3&api_key=a77367ded6d762442d5f2076c42ea0df117d7992&include=mixes[lukesolomon]+pagination" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        mixset = [responseObject objectForKey:@"mix_set"];
        mixArray = [mixset objectForKey:@"mixes"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mixArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ViewController *destinationController = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    destinationController.titleText = [NSString stringWithFormat:@"%@",[[mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"name"]];
    
    destinationController.description = [NSString stringWithFormat:@"%@",[[mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"description"]];
    
    destinationController.imageURL = [[[mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"cover_urls"] objectForKey:@"cropped_imgix_url"];
    
}

@end