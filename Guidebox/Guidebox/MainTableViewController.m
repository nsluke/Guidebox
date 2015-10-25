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
#import "SearchState.h"

#include "Global.h"

@implementation MainTableViewController {
    NSArray *resultsArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    if ([[SearchState sharedManager].indexOfWhereToStart isKindOfClass:[NSNull class]]) {
        [SearchState sharedManager].indexOfWhereToStart = [NSNumber numberWithInt:0];
//    } else if ([[SearchState sharedManager].numberOfResultsToShow isKindOfClass:[NSNull class]]) {
        [SearchState sharedManager].numberOfResultsToShow = [NSNumber numberWithInt:10];
//    }
    
    NSLog(@"%@ & %@",[SearchState sharedManager].indexOfWhereToStart,[SearchState sharedManager].numberOfResultsToShow);

    self.titleSearchBar.delegate = self;
    
    [self getRequestToAPI];

}

#pragma mark - Network Requests
- (void)getRequestToAPI {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/%@/shows/all/%@/%@/all/all/", APIKEY, [[SearchState sharedManager].indexOfWhereToStart stringValue],[[SearchState sharedManager].numberOfResultsToShow stringValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        resultsArray = [responseObject objectForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)getRequestToAPIwithSearchString:(NSString *)searchString {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
    [manager GET:[NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/%@/search/title/%@/fuzzy", APIKEY, searchString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        resultsArray = [responseObject objectForKey:@"results"];
        
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
    
    cell.cellTitle = [[resultsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.cellDetails = [[resultsArray objectAtIndex:indexPath.row] objectForKey:@"first_aired"];
    [cell setCellImage: [[resultsArray objectAtIndex:indexPath.row] objectForKey:@"artwork_448x252"]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
}

#pragma mark - Search Bar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self getRequestToAPIwithSearchString:_titleSearchBar.text];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    ViewController *destinationController = [segue destinationViewController];
    
    if ([segue.identifier isEqual: @"showDetail"]) {
        
        destinationController.titleText = [NSString stringWithFormat:@"%@",[[resultsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"title"]];
        destinationController.details = [NSString stringWithFormat:@"%@",[[resultsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"first_aired"]];
        destinationController.imageURL = [[resultsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row]objectForKey:@"artwork_448x252"];
    }
    
    
}

@end