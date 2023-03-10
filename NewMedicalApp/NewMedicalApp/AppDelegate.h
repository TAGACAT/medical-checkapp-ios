//
//  AppDelegate.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TerminosCondiViewController.h"
#import "MisMedicinasViewController.h"
#import "MisTestViewController.h"
#import "PendingViewController.h"
#import "NotificacionesDALC.h"
#import "MeasureViewController.h"
#import "IntakeViewController.h"
#import "SocialViewController.h"
#import "MoreViewController.h"

#import "FBConnect.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"

#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, FBDialogDelegate, SA_OAuthTwitterControllerDelegate, FBSessionDelegate>{
    
    Facebook *_facebook;
    SA_OAuthTwitterEngine *_twitterEngine;
    
    UITabBarController *myTabBar;
    
    MBProgressHUD *hud;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) SA_OAuthTwitterEngine *twitterEngine;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UITabBarController *myTabBar;

- (void)onAuthorizeFacebook:(NSNotification *)notification;
- (void)onDeauthorizeFacebook:(NSNotification *)notification;
- (void)onAuthorizeTwitter:(NSNotification *)notification;
- (void)onDeauthorizeTwitter:(NSNotification *)notification;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


-(void)CreaTabBarControllerConIndice:(int)IndiceTab ConOtroIndice:(int)IndiceNavigation;

@end
