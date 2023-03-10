//
//  MoreViewController.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "UserDataViewController.h"
#import "AppDelegate.h"
#import "Drug.h"
#import "Test.h"
#import "Appirater.h"
#import "TermsViewController.h"

#define APP_URL @"http://itunes.apple.com/us/app/medical-check-app/id544441595?ls=1&mt=8"

@implementation MoreViewController

@synthesize menuArray;

#pragma mark - Activity LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"More";
        menuArray = [[NSArray alloc] initWithObjects:@"User Data",@"Recommend",@"Rate",@"Help",@"Terms and Conditions", nil];
    }
    return self;
}

- (void)dealloc {
    [menuArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Test Methods





#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            UserDataViewController *viewController = [[UserDataViewController alloc] initWithNibName:@"UserDataViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            break;
        }
        case 1: {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                [mailer setSubject:@"Check this app on iTunes App Store"];
                NSString *emailBody = [NSString stringWithFormat:@"Check this app on iTunes App Store: \n%@",APP_URL];
                [mailer setMessageBody:emailBody isHTML:NO];
                [self presentModalViewController:mailer animated:YES];
                [mailer release];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Your device doesn't support the composer sheet"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                [alert release];
            }
            break;
        }
        case 2: {
            [Appirater userDidSignificantEvent:YES];
            break;
        }
        case 3:
            ;
            break;
        case 4: {
            TermsViewController *viewController = [[TermsViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            break;
        }
    }

    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [menuArray count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    

    cell.textLabel.text = [menuArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"UserData.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"Recommend.png"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"Rate.png"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"Help.png"];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"TermsConditions.png"];
            break;
    }
    
    
    return cell;
    
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
