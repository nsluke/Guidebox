//
//  NetworkCommunication.h
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkCommunication : NSObject

+ (instancetype)sharedManager;
- (NSArray *)getFromGuideboxAPI;

@property NSString *searchType;
@property NSString *searchTerms;
@property NSDictionary *fetchedData;
@property (atomic, weak) NSArray *fetchedDataAsArray;

@end
