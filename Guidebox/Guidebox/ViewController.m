//
//  ViewController.m
//  Guidebox
//
//  Created by Luke Solomon on 10/8/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailView;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelTitle.text = self.titleText;
    
    self.detailView.text = self.details;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageURL]];
}

@end
