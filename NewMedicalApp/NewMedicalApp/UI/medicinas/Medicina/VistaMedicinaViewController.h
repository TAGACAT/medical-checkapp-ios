//
//  VistaMedicinaViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "HeaderDrugDALC.h"
#import "PickerViewNumber.h"
#import "PickerViewList.h"
#import "ScheduleTimeViewController.h"
#import "ScheduleIntervalMedicinasViewController.h"
#import "ScheduleCustomMedsViewController.h"
#import "NotificacionesDALC.h"
#import "MBProgressHUD.h"
#import "RefillAlarmViewController.h"

@interface VistaMedicinaViewController : UIViewController <UIAlertViewDelegate>{
    
    IBOutlet UILabel *lblNombreMedicina;
    
    IBOutlet UIButton *btnSeleccionScheduleTime;
    IBOutlet UIButton *btnPackageSize;
    IBOutlet UIButton *btnPildorasRestantes;
    IBOutlet UISwitch *swRefillAlarm;
    
    NSMutableArray *arrayTiposScheduleTime;
    
    Drug *objDrug;
    
    MedicinaBE *objDrugBE;
    BOOL modifico;
    
    MBProgressHUD *hud;

    IBOutlet UIButton *btnConfigurar;
    
}

@property (readwrite, retain) NSMutableArray *arrayTiposScheduleTime;
@property (readwrite, retain) Drug *objDrug;
@property (readwrite, retain) MedicinaBE *objDrugBE;


-(IBAction)ClicSeleccionScheduleTime:(id)sender;
-(IBAction)ClicConFigurarScheduleTime:(id)sender;

-(IBAction)ClicRefillAlarm:(id)sender;
-(IBAction)ClicPackageSize:(id)sender;


@end
