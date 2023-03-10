//
//  ScheduleIntervalMedicinasViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "KalViewController.h"
#import "OSP_DateManager.h"
#import "PickerViewList.h"
#import "PickerViewInterval.h"
#import "PickerViewDate.h"


@interface ScheduleIntervalMedicinasViewController : UIViewController{
    
    
    IBOutlet UIButton *btnStartDate;
    IBOutlet UIButton *btnEndDate;
    IBOutlet UIButton *btnDose;
    IBOutlet UIButton *btnInterval;
    IBOutlet UIButton *btnFristTake;
    IBOutlet UISwitch *btnInterruption;
    IBOutlet UIButton *btnBedTime;
    
    IBOutlet UILabel *lblTitulo;
    
    ScheduleIntervalBE *objIntervalBE;
    NSString *NombreTitulo;
    
    NSNumber *numberMenor;
    NSNumber *numberMayor;
    NSMutableArray *intervalArrayNumber;
    NSMutableArray *intervalArrayString;
    
}

@property (readwrite, retain) NSString *NombreTitulo;
@property (readwrite, retain) NSNumber *numberMenor;
@property (readwrite, retain) NSNumber *numberMayor;
@property (readwrite, retain) ScheduleIntervalBE *objIntervalBE;
@property (readwrite, retain) NSMutableArray *intervalArrayNumber;
@property (readwrite, retain) NSMutableArray *intervalArrayString;

-(IBAction)clicBtnStartDate:(id)sender;
-(IBAction)clicBtnEndDate:(id)sender;
-(IBAction)clicBtnDose:(id)sender;
-(IBAction)clicBtnInterval:(id)sender;
-(IBAction)clicBtnFristTake:(id)sender;
-(IBAction)clicBtnInterruption:(id)sender;
-(IBAction)clicBtnBebTime:(id)sender;

@end
