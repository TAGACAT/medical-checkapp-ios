//
//  SocialViewController.m
//  MedApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialViewController.h"
#import "DidYouKnowDatasource.h"
#import "DidYouKnow.h"
#import "AppDelegate.h"

#define TWITTER_INVALID_DIALOG 9999
#define FACEBOOK_INVALID_DIALOG 9998
#define TWITTER_VALID_DIALOG 9997
#define FACEBOOK_VALID_DIALOG 9996

@implementation SocialViewController

@synthesize txtViewContent = _txtViewContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Social";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_didYouKnow release];
    [_txtViewContent release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_didYouKnow || ![_didYouKnow isEqual:[NSNull null]]  || _didYouKnow != nil) {
       // [_didYouKnow release];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDate *lastUpdate = [userDefault objectForKey:@"LastUpdate"];
    NSDate *today = [NSDate date];
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponents = [calendar components:flags fromDate:today];
    NSDateComponents *lastUpdateComponents = [calendar components:flags fromDate:lastUpdate];
    NSDate *todayWithoutHours = [calendar dateFromComponents:todayComponents];
    NSDate *lastUpdateWithout = [calendar dateFromComponents:lastUpdateComponents];
    
    if([todayWithoutHours compare:lastUpdateWithout]) {
        
        DidYouKnowDatasource *datasource = [[[DidYouKnowDatasource alloc] init] autorelease];
        [datasource openDatabase];
        NSMutableArray *didYouKnowArray = [[[NSMutableArray alloc] init] autorelease];
        [didYouKnowArray addObjectsFromArray:[datasource getDidYouKnows]];
        int count = [didYouKnowArray count];
        int random = 0;
        int lastIdentifier = [userDefault integerForKey:@"LastIdentifier"];
        do {
            random = arc4random()%count;
        } while (random==lastIdentifier);
        _didYouKnow = [didYouKnowArray objectAtIndex:random];
        [userDefault setObject:today forKey:@"LastUpdate"];
        [userDefault setInteger:[_didYouKnow.identifier intValue] forKey:@"LastIdentifier"];
        [userDefault setObject:_didYouKnow.content forKey:@"LastContent"];
        [userDefault synchronize];
        
    }
    else {
        
        _didYouKnow = [[DidYouKnow alloc] init];
        _didYouKnow.identifier = [NSNumber numberWithInt:[userDefault integerForKey:@"LastIdentifier"]];
        _didYouKnow.content = [NSString stringWithString:[userDefault objectForKey:@"LastContent"]];

    }
    
    [_txtViewContent setText:_didYouKnow.content];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.txtViewContent = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onClickTwitterButton:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIAlertView *alertView = nil;
    
    if([appDelegate.twitterEngine isAuthorized]) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"You're about to share this \"Did You Know\" on Twitter. Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = TWITTER_VALID_DIALOG;
        
    }
    else {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enable Twitter first. Go to More > User Date in order to enable this feature" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take me there", nil];
        alertView.tag = TWITTER_INVALID_DIALOG;
    }
    
    [alertView show];
    
}

- (IBAction)onClickFacebookButton:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIAlertView *alertView = nil;
    
    if(appDelegate.facebook.isSessionValid) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"You're about to share this \"Did You Know\" on Facebook. Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = FACEBOOK_VALID_DIALOG;
        
    }
    else {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enable Facebook first. Go to More > User Date in order to enable this feature" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take me there", nil];
        alertView.tag = FACEBOOK_INVALID_DIALOG;
    }
    
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (alertView.tag == TWITTER_VALID_DIALOG) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"correct publication" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [alert show];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateTwitter" object:_txtViewContent.text];
        }
        else if (alertView.tag == TWITTER_INVALID_DIALOG) {
            //Change Tab
        }
        else if (alertView.tag == FACEBOOK_VALID_DIALOG) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFacebook" object:_txtViewContent.text];
        }
        else if (alertView.tag == FACEBOOK_INVALID_DIALOG) {
            //Change Tab
        }
    }
    else {
        ;
    }
    
    [alertView release];
    
}

@end
