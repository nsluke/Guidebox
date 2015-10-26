//
//  ResponseTableViewCell.m
//  
//
//  Created by Luke Solomon on 10/25/15.
//
//

#import "ResponseTableViewCell.h"

@interface ResponseTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end


@implementation ResponseTableViewCell

-(void)setCellTitle:(NSString *)cellTitle {
    _title.text = cellTitle;
}

-(void)setCellDetails:(NSString *)cellDetails {
    _details.text = cellDetails;
}



@end
