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
#import "AFNetworking.h"

@interface MainTableViewController ()
@end

@implementation MainTableViewController {
    NSArray *temporaryArray;
    NSDictionary *temporaryDictionary;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    //AFNetworking asynchronous url request
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api-public.guidebox.com/v1.43/US/rKpHnCwMGJau0dHs6J3wYVYWcIlvm39e/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
//        temporaryDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        temporaryDictionary = responseObject;
        temporaryArray = [responseObject allValues];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return the search results
//    return 1;
    return [temporaryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"tableView: %@", [temporaryDictionary objectForKey:@"results"]);
    NSLog(@"tableView: %@", [temporaryArray objectAtIndex:indexPath.row]);
    
    CustomTableViewCell *temporaryCell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];
    
    if ([temporaryArray objectAtIndex:indexPath.row] != nil) {
        
        NSString *cellTitleString = [temporaryDictionary objectForKey:@"results"];
        if (cellTitleString != nil) {
            NSLog(@"cellTitleString: %@", cellTitleString);
            temporaryCell.cellTitle = cellTitleString;

        }
//        NSString *cellTitleString = [temporaryArray objectAtIndex:indexPath.row];
//        temporaryCell.cellDetails = cellTitleString;

    }
    

    
    

    return temporaryCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end