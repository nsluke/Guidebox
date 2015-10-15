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

- (IBAction)backButtonPushed:(id)sender;

@end

@implementation ViewController

@synthesize title;
@synthesize description;
@synthesize imageURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelTitle.text = self.title;
    self.detailView.text = self.description;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageURL]];
//    [self.imageView

}



- (IBAction)backButtonPushed:(id)sender {
    [self performSegueWithIdentifier:@"UnwindSegue" sender:self];
}

@end
