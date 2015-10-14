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
#import "MixObject.h"
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


-(void)viewDidLoad {
    [super viewDidLoad];

    //AFNetworking asynchronous url request
    [self getRequestToAPI];
}

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
           [self getRequestForImage];
//            [self.tableView reloadData];
            NSLog(@"mixarray count: %lu", (unsigned long)mixArray.count);
 
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getRequestForImage {
    
    for (int i = 0; i < mixArray.count; i++) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFImageResponseSerializer serializer];
        
        NSDictionary* URLDictionary = [NSDictionary dictionaryWithDictionary:[[mixArray objectAtIndex:i] objectForKey:@"cover_urls"]];
        
        NSString* urlForImage = [URLDictionary objectForKey:@"cropped_imgix_url"];
        NSLog(@"URL For Image: %@",urlForImage);
        
        [manager GET:urlForImage parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            [fetchedImageArray addObject:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return the search results
//    return 1;
    return [mixArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    currentMix = [mixArray objectAtIndex:indexPath.row];
    imageURLs = [currentMix objectForKey:@"cover_urls"];
    coverImageURL = [NSString stringWithFormat:@"%@", [imageURLs objectForKey:@"cropped_imgix_url"]];
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];

    
    NSString *cellTitleString = [currentMix objectForKey:@"name"];

    cell.cellTitle = cellTitleString;
    cell.cellDetails = [currentMix objectForKey:@"description"];
    NSLog(@"fetched Image: %@", [fetchedImageArray objectAtIndex:indexPath.row]);
    cell.cellImage = [fetchedImageArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController *destinationController = [segue destinationViewController];
    
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    NSLog(@"%@", [[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"description"]);
    
    destinationController.playlist.title = [[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"name"];
    
    destinationController.playlist.details = [[self.mixArray objectAtIndex:selectedIndexPath.row]objectForKey:@"description"];
}

#pragma mark - Unwind Segue
- (IBAction)unwindToTableView:(UIStoryboardSegue *)unwindSegue {
    
}

@end