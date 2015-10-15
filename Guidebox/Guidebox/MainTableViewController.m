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

#include "Global.h"

@implementation MainTableViewController {
    NSArray *mixArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self getRequestToAPI];

}

#pragma mark - Network Requests
- (void)getRequestToAPI {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"https://8tracks.com/mix_sets/staff-picks.json?api_version=3&api_key=%@&include=mixes[lukesolomon]+pagination", APIKEY] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        mixArray = [[responseObject objectForKey:@"mix_set" ] objectForKey:@"mixes"] ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];
    
    cell.cellTitle = [[mixArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.cellDetails = [[mixArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    [cell setCellImage: [[[mixArray objectAtIndex:indexPath.row] objectForKey:@"cover_urls"] objectForKey:@"cropped_imgix_url"]];

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
    
    destinationController.titleText = [NSString stringWithFormat:@"%@",[[mixArray objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"name"]];
    destinationController.details = [NSString stringWithFormat:@"%@",[[mixArray objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"description"]];
    destinationController.imageURL = [[[mixArray objectAtIndex:self.tableView.indexPathForSelectedRow.row]objectForKey:@"cover_urls"] objectForKey:@"cropped_imgix_url"];

    
    
}

@end