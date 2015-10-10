//
//  NetworkCommunication.m
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "NetworkCommunication.h"

@implementation NetworkCommunication



+ (void) getFromGuideboxAPI {
    NSString *fixedUrl = [NSString stringWithFormat:@"http://api-public.guidebox.com/v1.43/US/SuQW8TVSFTJXcfPwjVk8d9p06nLCfn/ %@%@",_HerokuURL,urlID];
    
    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:requestID];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler: ^void (NSData *data, NSURLResponse *response, NSError *error) {
        self.myData = data;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        if (responseStatusCode == 200 && data) {
            dispatch_async(dispatch_get_main_queue(), blockName);
            // do something with this data
            // if you want to update UI, do it on main queue
        } else {
            // error handling
            NSLog(@"ERROR: Heroku");
        }
    }];
    [dataTask resume];
}


@end
