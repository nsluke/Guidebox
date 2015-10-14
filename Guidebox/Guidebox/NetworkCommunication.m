//
//  NetworkCommunication.m
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "NetworkCommunication.h"
#import "MainTableViewController.h"
#import "AFNetworking.h"

@implementation NetworkCommunication {
    
}

@synthesize fetchedData;
@synthesize searchType;
@synthesize searchTerms;
@synthesize fetchedDataAsArray;

+ (instancetype)sharedManager {
    static NetworkCommunication *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (NSArray *) getFromGuideboxAPI {
//    NSString *fixedUrl = [NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/SuQW8TVSFTJXcfPwjVk8d9p06nLCfn/ %@ / %@", searchType, searchTerms];
    NSString *fixedUrl = [NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/rKpHnCwMGJau0dHs6J3wYVYWcIlvm39e/"];

    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler: ^void (NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
            
                fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                fetchedDataAsArray = [fetchedData allValues];
                
            });
        
        } else {
            // error handling
            NSLog(@"ERROR: connection to Guidebox");
        }
    }];
    [dataTask resume];
    return fetchedDataAsArray;
}

- (void) getDictFromGuideboxAPI {

//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
    //        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    //        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    //    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
    //        NSLog(@"File downloaded to: %@", filePath);
//    }];
    
    // Download JSON

    
    
    
    NSString *fixedUrl = [NSString stringWithFormat:@"https://api-public.guidebox.com/v1.43/US/rKpHnCwMGJau0dHs6J3wYVYWcIlvm39e/"];
    
    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler: ^void (NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"fetched data: %@", fetchedData);
                
                
            });
            
        } else {
            // error handling
            NSLog(@"ERROR: connection to Guidebox");
        }
    }];
    [dataTask resume];
    NSLog(@"connected to Guidebox");

}




@end
