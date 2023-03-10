//
//  RefillAlarmViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicinaBE.h"
#import "PickerViewNumber.h"

@interface RefillAlarmViewController : UIViewController{
    
    IBOutlet UILabel *lblTitulo;
    IBOutlet UISwitch *swcAlarma;
    IBOutlet UIButton *btnPills;
    
    MedicinaBE *objMedicinaBE;
}

@property (readwrite, retain) MedicinaBE *objMedicinaBE;

-(IBAction)clicbtnPills:(id)sender;
-(IBAction)changeValueAlarma:(id)sender;

@end
