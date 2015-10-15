//
//  CustomTableViewCell.h
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic) NSString *cellTitle;
@property (nonatomic) NSString *cellDetails;

//cellImageURL needs to be it's own method because the URL for the image gets passed in as an argument from the tableViewCell
-(void)setCellImage:(NSString *)cellImageUrl;

@end
