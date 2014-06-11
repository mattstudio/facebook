//
//  MainViewController.m
//  FB Story
//
//  Created by Matt Mitchell on 6/9/14.
//  Copyright (c) 2014 Matt Mitchell. All rights reserved.
//

#import "MainViewController.h"
#import "TTTAttributedLabel.h"

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
    
    CGRect postDescriptionFrame = CGRectMake(20, 119, 280, 94);
    TTTAttributedLabel *postDescriptionLabel = [[TTTAttributedLabel alloc] initWithFrame:postDescriptionFrame];
    [postDescriptionLabel setTextColor:[UIColor blackColor]];
    [postDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    postDescriptionLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed

    
    postDescriptionLabel.font = [UIFont systemFontOfSize:14];
    postDescriptionLabel.numberOfLines = 0;
    postDescriptionLabel.lineHeightMultiple = 1.1;

    NSString *text = @"From collarless shirts to high-waisted pants, #Her's costume designer, Casey Storm, explains how he created his fashion looks for the future: http://bit.ly/1jV9zM8";
    
     
    [postDescriptionLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"#Her" options:NSCaseInsensitiveSearch];
        NSRange strikeRange = [[mutableAttributedString string] rangeOfString:@"sit amet" options:NSCaseInsensitiveSearch];
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(font) range:boldRange];
            [mutableAttributedString addAttribute:kTTTStrikeOutAttributeName value:[NSNumber numberWithBool:YES] range:strikeRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    
    
    [self.view addSubview:postDescriptionLabel];
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
