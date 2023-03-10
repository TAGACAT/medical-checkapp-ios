//
//  DrugNextViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "OSP_DateManager.h"
#import "Drug.h"
#import "DrugNextDetailViewController.h"
#import "MBProgressHUD.h"


@interface DrugNextViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UISegmentedControl *mySegmented;
    IBOutlet UITableView *myTable;
    
    NSMutableArray *ArrayTable;
    NSMutableArray *ArrayNotificaciones;
    Drug *aMedicina;
    
    MBProgressHUD *hud;
}

@property (readwrite, retain) Drug *aMedicina;
@property (readwrite, retain) NSMutableArray *ArrayTable;
@property (readwrite, retain) NSMutableArray *ArrayNotificaciones;

-(IBAction) segmentedControlIndexChanged:(UISegmentedControl *)sender;

@end
