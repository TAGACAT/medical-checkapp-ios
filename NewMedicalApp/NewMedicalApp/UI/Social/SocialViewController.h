//
//  SocialViewController.h
//  MedApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class DidYouKnow;

@interface SocialViewController : UIViewController <UIAlertViewDelegate> {
    
    DidYouKnow *_didYouKnow;
    UITextView *_txtViewContent;
    
}

@property (nonatomic,retain) IBOutlet UITextView *txtViewContent;

- (IBAction)onClickFacebookButton:(id)sender;
- (IBAction)onClickTwitterButton:(id)sender;

@end
