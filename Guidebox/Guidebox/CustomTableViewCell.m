//
//  CustomTableViewCell.m
//  Guidebox
//
//  Created by Luke Solomon on 10/9/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"


@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation CustomTableViewCell


-(void)setCellImage:(NSString *)cellImageUrl {
//    NSLog(@"%@", self.cellImage);
//    [self.image setImage:[UIImage imageWithData:self.cellImage] forState:UIControlStateNormal];
    
    [self.image setImageWithURL:[NSURL URLWithString:cellImageUrl]];

//    self.image.image = cellImage;
}

-(void)setCellTitle:(NSString *)cellTitle {
//    NSLog(@"cellTitle: %@", cellTitle);
    _title.text = [NSString stringWithFormat:@"%@", cellTitle];
}

-(void)setCellDetails:(NSString *)cellDetails {
    _details.text = cellDetails;
}

@end
