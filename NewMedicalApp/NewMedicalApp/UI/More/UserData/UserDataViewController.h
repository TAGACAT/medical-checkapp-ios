//
//  UserDataViewController.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataViewController : UIViewController <UIAlertViewDelegate> {
    
    UILabel *_lblTwitterStatus;
    UIButton *_btnTwitter;
    UILabel *_lblFacebookStatus;
    UIButton *_btnFacebook;
    
}

@property (nonatomic,retain) IBOutlet UILabel *lblTwitterStatus;
@property (nonatomic,retain) IBOutlet UILabel *lblFacebookStatus;
@property (nonatomic,retain) IBOutlet UIButton *btnTwitter;
@property (nonatomic,retain) IBOutlet UIButton *btnFacebook;

- (IBAction)onClickTwitterButton:(id)sender;
- (IBAction)onClickFacebookButton:(id)sender;

- (void)onSucceedAuthorizeFacebook:(NSNotification *)notification;
- (void)onSucceedDeauthorizeFacebook:(NSNotification *)notification;
- (void)onSucceedAuthorizeTwitter:(NSNotification *)notification;
- (void)onSucceedDeauthorizeTwitter:(NSNotification *)notification;

- (void)setupTwitterEnabled;
- (void)setupTwitterDisabled;
- (void)setupFacebookEnabled;
- (void)setupFacebookDisabled;

@end
