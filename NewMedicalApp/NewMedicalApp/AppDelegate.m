//
//  AppDelegate.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#define FACEBOOK_APP_ID @"354898304577313"
#define FACEBOOK_WEB @"http://www.google.com"
#define TWITTER_CONSUMER_KEY @"NmGZTkP4VaiYXKIeAT6tQ"
#define TWITTER_CONSUMER_SECRET @"2UCqQsstD7KYZYYRADqSkEEHS5KVIZNBOVEYOk50jc"


@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize facebook = _facebook;
@synthesize twitterEngine = _twitterEngine;
@synthesize myTabBar;


-(void)CalcularNuevasNotificaciones{
    
    NSArray *arrayMeds = [DrugDALC Listar];
    NSArray *arrayTest = [TestDALC Listar];
    
    for (int i = 0; i < [arrayMeds count]; i++) {
        
        Drug *objDrug = [arrayMeds objectAtIndex:i];
        
        if ([objDrug.drugScheduleType intValue] >= 0 && [objDrug.drugScheduleType intValue] <= 3) {
            [NotificacionesDALC CalcularNotificacionesTimeTake:objDrug];
        }else if ([objDrug.drugScheduleType intValue] == 5){
            [NotificacionesDALC CalcularNotificacionesInterval:objDrug];
        }else if ([objDrug.drugScheduleType intValue] == 6){
            [NotificacionesDALC CalcularNotificacionesCustom:objDrug];
        }else{
            [NotificacionesDALC EliminarNotificacionesPorMedicina:objDrug];
        }
    }
    
    for (int i = 0 ; i < [arrayTest count]; i++) {
        
        Test *objTest = [arrayTest objectAtIndex:i];
        
        if ([objTest.testScheduleType intValue] >= 0 && [objTest.testScheduleType intValue] <= 3) {
            [NotificacionesDALC CalcularNotificacionesTimeMeasureTest:objTest];
        }else if ([objTest.testScheduleType intValue] == 5){
            [NotificacionesDALC CalcularNotificacionesIntervalTest:objTest];
        }else if ([objTest.testScheduleType intValue] == 6){
            [NotificacionesDALC CalcularNotificacionesCustomTest:objTest];
        }else{
            [NotificacionesDALC EliminarNotificacionesPorTest:objTest];
        }
    }
    
    [NotificacionesDALC CrearNuevaNotificacion];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification) {

        if (notification.userInfo) {
            [NotificacionesDALC CrearNuevaNotificacion];
            
            [self.myTabBar setSelectedIndex:3];
            
//            Notificaciones *objNotificacion;
//            
//            NSDictionary *userInfo = notification.userInfo;
//            if ([userInfo objectForKey:@"CodDrug"]) {
//                objNotificacion  = [NotificacionesDALC ObtenerNotificacionPorIdDrug:[DrugDALC ObtenerMedicinaPorPK:[userInfo objectForKey:@"CodDrug"]] enFecha:[userInfo objectForKey:@"Fecha"]];
//                
//                IntakeViewController *viewController = [[[IntakeViewController alloc] initWithNibName:nil bundle:nil] autorelease];
//                [viewController setModo:2];
//                [viewController setObjNoti:objNotificacion];
//                UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
//                [self.window.rootViewController presentModalViewController:navController animated:YES];
//                
//                
//            }else{
//                objNotificacion  = [NotificacionesDALC ObtenerNotificacionPorIdDrug:[DrugDALC ObtenerMedicinaPorPK:[userInfo objectForKey:@"CodTest"]] enFecha:[userInfo objectForKey:@"Fecha"]];
//                
//                MeasureViewController *viewController = [[[MeasureViewController alloc] initWithNibName:nil bundle:nil] autorelease];
//                [viewController setModo:2];
//                [viewController setObjNoti:objNotificacion];
//                UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
//                [self.window.rootViewController presentModalViewController:navController animated:YES];
//            }
        }
        
        
    }
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 
}

- (void)dealloc
{
    [myTabBar release];
    [_facebook release];
    [_twitterEngine release];
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


#pragma mark - FBSessionDelegate

- (void)fbDidLogin {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedAuthorizeFacebook" object:nil];
    
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
    
    
}

- (void)fbDidExtendToken:(NSString*)accessToken expiresAt:(NSDate*)expiresAt {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

- (void)fbDidLogout {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedDeauthorizeFacebook" object:nil];
    
}

- (void)fbSessionInvalidated {
    
    
    
}

#pragma mark - NSNotificationCenter

- (void)onAuthorizeFacebook:(NSNotification *)notification {
    
    if (![_facebook isSessionValid]) {
        [_facebook authorize:nil];
    }
    
}

- (void)onDeauthorizeFacebook:(NSNotification *)notification {
    
    [_facebook logout];
    
}

- (void)onAuthorizeTwitter:(NSNotification *)notification {
    
    UIViewController *controllerReference = (UIViewController *)[notification object];
    UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _twitterEngine delegate: self];
    [controllerReference presentModalViewController:controller animated: YES];
    
}

- (void)onDeauthorizeTwitter:(NSNotification *)notification {
    
    [_twitterEngine clearAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedDeauthorizeTwitter" object:nil];
    
}

- (void)onUpdateTwiter:(NSNotification *)notification {
    
    NSString *update = (NSString *)[notification object];
    [_twitterEngine sendUpdate:update];
    
}

- (void)onUpdateFacebook:(NSNotification *)notification {
    
    NSString *update = (NSString *)[notification object];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FACEBOOK_APP_ID, @"app_id",
                                   FACEBOOK_WEB, @"link",
                                   @"Medical Check App", @"name",
                                   @"Did you know?", @"caption",
                                   update, @"description",
                                   nil];
    [_facebook dialog:@"feed" andParams:params andDelegate:self];
    
}

#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
    
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
    
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
    
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
    
}

#pragma mark SA_OAuthTwitterController Delegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
    
	NSLog(@"Authenticated with user %@", username);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedAuthorizeTwitter" object:nil];
    
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
    
	NSLog(@"Authentication Failure");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedDeauthorizeTwitter" object:nil];
    
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
    
	NSLog(@"Authentication Canceled");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SucceedDeauthorizeTwitter" object:nil];
    
}



#pragma mark -

-(void)CrearTerminosCondiciones{
    
    UIViewController *myView = [[[TerminosCondiViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:myView] autorelease];
}


-(void)CreaTabBarControllerConIndice:(int)IndiceTab ConOtroIndice:(int)IndiceNavigation{
    
    
    MisMedicinasViewController *controller1 = [[[MisMedicinasViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller1.tabBarItem setImage:[UIImage imageNamed:@"medications2.png"]];
    controller1.title = @"Medications";
    if (IndiceNavigation == 1) 
        [controller1 setHacerPush:YES];
    UINavigationController *navigation1 = [[[UINavigationController alloc] initWithRootViewController:controller1] autorelease];
    
    MisTestViewController *controller2 = [[[MisTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller2.tabBarItem setImage:[UIImage imageNamed:@"Medical Tests1.png"]];
    controller2.title = @"Tests";
    if (IndiceNavigation == 2) 
        [controller2 setHacerPush:YES];
    UINavigationController *navigation2 = [[[UINavigationController alloc] initWithRootViewController:controller2] autorelease];
    
    SocialViewController *controller3 = [[[SocialViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller3.tabBarItem setImage:[UIImage imageNamed:@"Social Network.png"]];
    controller3.title = @"Social";
    UINavigationController *navigation3 = [[[UINavigationController alloc] initWithRootViewController:controller3] autorelease];
    
    PendingViewController *controller4 = [[[PendingViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller4.tabBarItem setImage:[UIImage imageNamed:@"Pending.png"]];
    controller4.title = @"Pending";
    UINavigationController *navigation4 = [[[UINavigationController alloc] initWithRootViewController:controller4] autorelease];
    
    int pendientes = [[NotificacionesDALC ListarPentiendesMeds] count] + [[NotificacionesDALC ListarPentiendesTest] count];
    if (pendientes == 0)
        [navigation4.tabBarItem setBadgeValue:nil];
    else
        [navigation4.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",pendientes]];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = pendientes;
    
    MoreViewController *controller5 = [[[MoreViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller5.tabBarItem setImage:[UIImage imageNamed:@"more.png"]];
    controller5.title = @"more";
    UINavigationController *navigation5 = [[[UINavigationController alloc] initWithRootViewController:controller5] autorelease];

    
//    UITabBarController *myTabar = [[[UITabBarController alloc] init] autorelease];
    myTabBar = [[UITabBarController alloc] init];
    [myTabBar setViewControllers:[NSArray arrayWithObjects:navigation1, navigation2, navigation3, navigation4, navigation5, nil]];
    myTabBar.delegate = self;
    [myTabBar setSelectedIndex:IndiceTab];
      
    self.window.rootViewController = myTabBar;
}


- (BOOL)AceptoTerminos {
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    
    if ([userD objectForKey:@"isTermsAccept"] == nil || [[userD objectForKey:@"isTermsAccept"] boolValue] == NO) {
        
        [userD setBool:NO forKey:@"isTermsAccept"];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        return NO;
    }
    return YES;
}



-(void)nuevasNotificaciones{
    
    int Mes = [OSP_DateManager DameNumeroMesDeFecha:[NSDate date]];
    int Anio = [OSP_DateManager DameNumeroAnioDeFecha:[NSDate date]];
    
    NSArray *arrayAux = [NotificacionesDALC Listar];
    
    if ([arrayAux count] != 0) {
        Notificaciones *obj = [arrayAux objectAtIndex:[arrayAux count] - 1];
        
        int MesAnterior = [OSP_DateManager DameNumeroMesDeFecha:obj.fechaHora];
        int AnioAnterior = [OSP_DateManager DameNumeroAnioDeFecha:obj.fechaHora];
        
        if (Mes > MesAnterior) {
            [self CalcularNuevasNotificaciones];
            [NotificacionesDALC CrearNuevaNotificacion];
        }else{
            if (Anio>AnioAnterior) {
                [self CalcularNuevasNotificaciones];
                [NotificacionesDALC CrearNuevaNotificacion];
            }
        }
    }
    [hud hide:YES];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAuthorizeFacebook:) name:@"AuthorizeFacebook" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeauthorizeFacebook:) name:@"DeauthorizeFacebook" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAuthorizeTwitter:) name:@"AuthorizeTwitter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeauthorizeTwitter:) name:@"DeauthorizeTwitter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUpdateTwiter:) name:@"UpdateTwitter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUpdateFacebook:) name:@"UpdateFacebook" object:nil];
    
    _facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    _twitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
    _twitterEngine.consumerKey = TWITTER_CONSUMER_KEY;
    _twitterEngine.consumerSecret = TWITTER_CONSUMER_SECRET;
    
    
    if (![self AceptoTerminos]) {
        [self CrearTerminosCondiciones];
    }else {
        [self CreaTabBarControllerConIndice:0 ConOtroIndice:0];
    }
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.labelText = @"checking notifications...";
    [hud show:YES];
    
    [self performSelector:@selector(nuevasNotificaciones) withObject:nil afterDelay:0.2];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewMedicalApp" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewMedicalApp.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [_facebook handleOpenURL:url];
}

@end
