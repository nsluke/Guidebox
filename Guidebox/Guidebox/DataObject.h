//
//  DataObject.h
//  Guidebox
//
//  Created by Luke Solomon on 10/17/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataObject : NSObject {
    NSString *category;
    NSString *name;
    NSString *description;
}

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *details;


+ (id)objectOfCategory:(NSString*)category name:(NSString*)name details:(NSString *)details;

@end
