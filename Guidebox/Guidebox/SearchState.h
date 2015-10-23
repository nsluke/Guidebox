//
//  SearchState.h
//  Guidebox
//
//  Created by Luke Solomon on 10/21/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchState : NSObject


@property (nonatomic) NSNumber *numberOfResultsToShow;
@property (nonatomic) NSNumber *indexOfWhereToStart;


+ (instancetype)sharedManager;


@end
