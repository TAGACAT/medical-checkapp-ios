//
//  ScheduleTimeTakeViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "PickerViewDate.h"
#import "PickerViewList.h"
#import "OSP_DateManager.h"

@interface ScheduleTimeTakeViewController : UIViewController{
    
    IBOutlet UIButton *btnTime;
    IBOutlet UIButton *btnDose;
    IBOutlet UILabel *lblTitulo;
    
    ScheduleTimeTakeBE *objTimeTakeBE;
    NSString *NombreTitulo;
    
}

@property (readwrite, retain) ScheduleTimeTakeBE *objTimeTakeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicBntTime:(id)sender;
-(IBAction)ClicBtnDose:(id)sender;

@end
