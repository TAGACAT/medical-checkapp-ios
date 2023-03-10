//
//  UserDataViewController.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserDataViewController.h"
#import "AppDelegate.h"
#define TWITTER_DIALOG 9999
#define FACEBOOK_DIALOG 9998

@implementation UserDataViewController

@synthesize lblTwitterStatus = _lblTwitterStatus, lblFacebookStatus = _lblFacebookStatus, btnTwitter = _btnTwitter, btnFacebook = _btnFacebook;

#pragma mark - Activity LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"User Data";
    }
    return self;
}

- (void)dealloc {
    [_lblTwitterStatus release];
    [_lblFacebookStatus release];
    [_btnTwitter release];
    [_btnFacebook release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSucceedAuthorizeFacebook:) name:@"SucceedAuthorizeFacebook" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSucceedDeauthorizeFacebook:) name:@"SucceedDeauthorizeFacebook" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSucceedAuthorizeTwitter:) name:@"SucceedAuthorizeTwitter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSucceedDeauthorizeTwitter:) name:@"SucceedDeauthorizeTwitter" object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDelegate.twitterEngine isAuthorized]) {
        [self setupTwitterEnabled];
    }
    else {
        [self setupTwitterDisabled];
    }
    
    if(appDelegate.facebook.isSessionValid) {
        [self setupFacebookEnabled];
    }
    else {
        [self setupFacebookDisabled];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.lblTwitterStatus = nil;
    self.lblFacebookStatus = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Methods

- (void)setupTwitterEnabled {
    
    [_lblTwitterStatus setText:@"Twitter is enabled"];
    [_lblTwitterStatus setTextColor:[UIColor greenColor]];
    [_btnTwitter setTitle:@"Disable Twitter" forState:UIControlStateNormal];
    
}

- (void)setupTwitterDisabled {
    
    [_lblTwitterStatus setText:@"Twitter is disabled"];
    [_lblTwitterStatus setTextColor:[UIColor redColor]];
    [_btnTwitter setTitle:@"Enable Twitter" forState:UIControlStateNormal];
    
}

- (void)setupFacebookEnabled {
    
    [_lblFacebookStatus setText:@"Facebook is enabled"];
    [_lblFacebookStatus setTextColor:[UIColor greenColor]];
    [_btnFacebook setTitle:@"Disable Facebook" forState:UIControlStateNormal];
    
}

- (void)setupFacebookDisabled {
    
    [_lblFacebookStatus setText:@"Facebook is disabled"];
    [_lblFacebookStatus setTextColor:[UIColor redColor]];
    [_btnFacebook setTitle:@"Enable Facebook" forState:UIControlStateNormal];
    
}

#pragma mark - IBActions

- (IBAction)onClickTwitterButton:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if([appDelegate.twitterEngine isAuthorized]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to disable Twitter? You won't be able to share contents on Twitter later" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = TWITTER_DIALOG;
        [alertView show];
        [alertView release];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AuthorizeTwitter" object:self];
    }
    
}
- (IBAction)onClickFacebookButton:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.facebook.isSessionValid) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to disable Facebook? You won't be able to share contents on Facebook later" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = FACEBOOK_DIALOG;
        [alertView show];
        [alertView release];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AuthorizeFacebook" object:nil];
    }
    
}

#pragma mark - UIAlertViewDelegate 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (alertView.tag == TWITTER_DIALOG) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DeauthorizeTwitter" object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DeauthorizeFacebook" object:nil];
        }
    }
    else {
        ;
    }
    
    [alertView release];
    
}

#pragma mark - NSNotificationCenter

- (void)onSucceedAuthorizeFacebook:(NSNotification *)notification {
   
    NSLog(@"Authorized on Facebook");
    [self setupFacebookEnabled];
       
}

- (void)onSucceedDeauthorizeFacebook:(NSNotification *)notification {
    
    NSLog(@"Deauthorized on Facebook");
    [self setupFacebookDisabled];
    
}

- (void)onSucceedAuthorizeTwitter:(NSNotification *)notification {
    
    NSLog(@"Authorized on Twitter");
    [self setupTwitterEnabled];
    
}

- (void)onSucceedDeauthorizeTwitter:(NSNotification *)notification {
    
    NSLog(@"Deauthorized on Twitter");
    [self setupTwitterDisabled];
    
}

@end
