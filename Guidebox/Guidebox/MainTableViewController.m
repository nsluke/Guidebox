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

@interface MainTableViewController ()


@end



@implementation MainTableViewController {
    NSArray *temporaryArray;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    temporaryArray = [[NetworkCommunication sharedManager] getFromGuideboxAPI];

    //set up search bar
//    self.searchBar.tintColor = [UIColor colorWithRed:0.0/255
//                                               green:1.0/255
//                                                blue:0.0
//                                               alpha:1.0/255];
//    
//    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;

}

#pragma mark - UITableViewDelegate

// check cells initially as they are selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

// uncheck cells
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return the search results
    return [temporaryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *temporaryCell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];
    NSString *cellTitleString = [temporaryArray objectAtIndex:indexPath.row];
    
    NSLog(@"print some shit: %@", [temporaryArray objectAtIndex:indexPath.row]);
    
    temporaryCell.cellTitle = cellTitleString;
    temporaryCell.cellDetails = cellTitleString;
    
    return temporaryCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end