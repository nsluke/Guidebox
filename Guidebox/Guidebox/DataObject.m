//
//  DataObject.m
//  Guidebox
//
//  Created by Luke Solomon on 10/17/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "DataObject.h"

@implementation DataObject

@synthesize category;
@synthesize name;
@synthesize details;





+ (id)objectOfCategory:(NSString *)category name:(NSString *)name details:(NSString *)details
{
    DataObject *newDataObject = [[self alloc] init];
    newDataObject.category = category;
    newDataObject.name = name;
    newDataObject.details = details;
    
    return newDataObject;
}


@end
