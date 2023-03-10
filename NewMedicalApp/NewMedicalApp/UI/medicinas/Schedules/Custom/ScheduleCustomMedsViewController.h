//
//  ScheduleCustomMedsViewController.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "PickerViewDate.h"
#import "OSP_DateManager.h"
#import "PickerViewNumber.h"
#import "ScheduleCustomDayController.h"
#import "HeaderDrugBE.h"
#import "KalViewController.h"


@interface ScheduleCustomMedsViewController : UIViewController{
    
    NSString *NombreTitulo;
    
    IBOutlet UILabel *lblTitulo;
    IBOutlet UIButton *btnStarDate;
    IBOutlet UIButton *btnEndDate;
    IBOutlet UIButton *btnNoDays;
    IBOutlet UIButton *btnConfigurar;
    
    ScheduleCustomBE *objScheduleCustomBE;
}

@property (readwrite, retain) NSString *NombreTitulo;
@property (readwrite, retain) ScheduleCustomBE *objScheduleCustomBE;


-(IBAction)ClicStarDate:(id)sender;
-(IBAction)ClicEndDate:(id)sender;
-(IBAction)ClicNoDays:(id)sender;

-(IBAction)ClicCustomDays:(id)sender;

@end
