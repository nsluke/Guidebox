//
//  CustomTableViewCell.m
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation CustomTableViewCell {
    
}

-(void)setCellImage:(NSData *)cellImage {
    
    _image.image = [UIImage imageWithData:cellImage];
    
}

-(void)setCellTitle:(NSString *)cellTitle {
    _title.text = cellTitle;

}

-(void)setCellDetails:(NSString *)cellDetails {
    _details.text = cellDetails;
}




@end
