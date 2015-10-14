//
//  ViewController.m
//  Guidebox
//
//  Created by Luke Solomon on 10/8/15.
//  Copyright © 2015 Luke Solomon. All rights reserved.
//

#import "ViewController.h"
#import "MixObject.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailView;

- (IBAction)backButtonPushed:(id)sender;

@end

@implementation ViewController

@synthesize title;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelTitle.text = self.playlist.title;
    self.detailView.text = self.playlist.details;

}

-(void)setCellImage:(NSData *)cellImage {
    _imageView.image = [UIImage imageWithData: self.playlist.image];
}

-(void)setCellTitle:(NSString *)cellTitle {
    _labelTitle.text = self.playlist.title;
}

-(void)setCellDetails:(NSString *)cellDetails {
    _detailView.text = self.playlist.details;
}

- (IBAction)backButtonPushed:(id)sender {
    [self performSegueWithIdentifier:@"UnwindSegue" sender:self];
}

@end
