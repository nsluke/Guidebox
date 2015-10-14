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

@implementation CustomTableViewCell

@synthesize cellImage;


-(void)setCellImage:(NSData *)cellImage {
    NSLog(@"%@", self.cellImage);
//    [self.image setImage:[UIImage imageWithData:self.cellImage] forState:UIControlStateNormal];
    
    self.image.image = [UIImage imageWithData:self.cellImage];
}

-(void)setCellTitle:(NSString *)cellTitle {
//    NSLog(@"cellTitle: %@", cellTitle);
    _title.text = [NSString stringWithFormat:@"%@", cellTitle];
}

-(void)setCellDetails:(NSString *)cellDetails {
    _details.text = cellDetails;
}

@end
