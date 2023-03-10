//
//  MenuMedicinasViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "HeaderDrugDALC.h"
#import "VistaMedicinaViewController.h"
#import "DrugNextViewController.h"
#import "DrugHistoryViewController.h"
#import "IntakeViewController.h"

@interface MenuMedicinasViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>{
    
    Drug *Medicina;
    NSMutableArray *arrayTable;
    
    IBOutlet UILabel *lblTitulo;
}

@property (readwrite, retain) Drug *Medicina;

-(IBAction)ClicRefill:(id)sender;
-(IBAction)ClicQuickIntake:(id)sender;

@end
