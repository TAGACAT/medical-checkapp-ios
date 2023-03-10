//
//  MisMedicinasViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugDALC.h"
#import "BuscarMedicinaViewController.h"
#import "MenuMedicinasViewController.h"


@interface MisMedicinasViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *arrayMedicamentos;
    
    IBOutlet UITableView *myTable;
    
    IBOutlet UIView *viewConMedicinas;
    IBOutlet UIView *viewSinMedicinas;
    
    BOOL hacerPush;
}

@property (readwrite, retain) NSMutableArray *arrayMedicamentos;
@property (readwrite) BOOL hacerPush;

-(IBAction)BuscarParaAgregar:(id)Sender;

@end
