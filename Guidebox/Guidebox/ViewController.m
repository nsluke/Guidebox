//
//  ViewController.m
//  Guidebox
//
//  Created by Luke Solomon on 10/8/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import "SearchState.h"
#import "Global.h"
#import "ResponseTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ViewController {
    NSArray *resultsArray;
    NSArray *resultsArrayForContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelTitle.text = self.titleText;
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageURL]];
    
    [self getRequestToAPI];
    [self getRequestToAPIForContent];
}


#pragma mark - getRequests
- (void)getRequestToAPI {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *URLString = [NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/%@/%@/%@/%@",
                           [SearchState sharedManager].searchRegion,
                           APIKEY,
                           [SearchState sharedManager].searchType,
                           _showID];
    
//    NSLog(@"URLString: %@", URLString);
    
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        resultsArray = [responseObject objectForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getRequestToAPIForContent {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *URLString = [NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/%@/%@/%@/available_content",
                           APIKEY,
                           [SearchState sharedManager].searchType,
                           _showID];
    
//    NSLog(@"URLString: %@", URLString);
    
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        resultsArrayForContent = [[[[responseObject objectForKey:@"results"]objectForKey:@"web"] objectForKey:@"episodes"]objectForKey:@"all_sources"];
        
//        NSLog(@"resultsArrayForContent: %@",resultsArrayForContent);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResponseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell" forIndexPath:indexPath];
    cell.cellTitle   = [[resultsArrayForContent objectAtIndex:indexPath.row]objectForKey:@"display_name"];
    cell.cellDetails = [[resultsArrayForContent objectAtIndex:indexPath.row]objectForKey:@"type"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultsArrayForContent count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
