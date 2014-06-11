//
//  MainViewController.m
//  FB Story
//
//  Created by Matt Mitchell on 6/9/14.
//  Copyright (c) 2014 Matt Mitchell. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *postBackgroundView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view from its nib.
    
    self.postBackgroundView.layer.cornerRadius = 5;
    self.postBackgroundView.layer.shadowColor = [UIColor.blackColor colorWithAlphaComponent: 0.2].CGColor;
    self.postBackgroundView.layer.shadowOffset = CGSizeMake(1.1, -0.1);
    self.postBackgroundView.layer.shadowOpacity = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
