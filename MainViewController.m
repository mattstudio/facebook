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
@property (weak, nonatomic) IBOutlet UIView *commentContainerView;
- (IBAction)onTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
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

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentContainerView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentContainerView.frame.size.height, self.commentContainerView.frame.size.width, self.commentContainerView.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentContainerView.frame = CGRectMake(0, self.view.frame.size.height - self.commentContainerView.frame.size.height, self.commentContainerView.frame.size.width, self.commentContainerView.frame.size.height);
                     }
                     completion:nil];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
