//
//  PendingViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificacionesDALC.h"
#import "Notificaciones.h"
#import "OSP_DateManager.h"
#import "Drug.h"
#import "MBProgressHUD.h"
#import "IntakeViewController.h"
#import "MeasureViewController.h"


@interface PendingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
        
    NSMutableArray *arrayTable;
    
    NSMutableArray *arrayMeds;
    NSMutableArray *arrayTest;
    
    IBOutlet UISegmentedControl *mySegmentedControl;
    IBOutlet UITableView *myTableView;
    IBOutlet UIToolbar *myToolBar;
    
    MBProgressHUD *hud;
    
    BOOL Editando;
    
    NSMutableArray *arrayTemporal;
}

@property (readwrite, retain) NSMutableArray *arrayTable;
@property (readwrite, retain) NSMutableArray *arrayMeds;
@property (readwrite, retain) NSMutableArray *arrayTest;

-(IBAction)seleccionSegmented:(id)sender;

- (IBAction)onClickDoneActionButton:(id)sender;
- (IBAction)onClickSkipActionButton:(id)sender;

@end
