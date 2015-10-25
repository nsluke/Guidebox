//
//  SearchState.m
//  Guidebox
//
//  Created by Luke Solomon on 10/21/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "SearchState.h"

@implementation SearchState
//
//@synthesize numberOfResultsToShow;
//@synthesize indexOfWhereToStart;



+ (instancetype)sharedManager {
    static SearchState *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

@end
