//
//  ScheduleConfigurarCustomTakeController.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "PickerViewDate.h"
#import "PickerViewList.h"
#import "OSP_DateManager.h"

@interface ScheduleConfigurarCustomTakeController : UIViewController{
    
    IBOutlet UIButton *btnTime;
    IBOutlet UIButton *btnDose;
    IBOutlet UILabel *lblTitulo;
    
    ScheduleCustomTakeBE *objTimeTakeBE;
    NSString *NombreTitulo;
    
}

@property (readwrite, retain) ScheduleCustomTakeBE *objTimeTakeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicBntTime:(id)sender;
-(IBAction)ClicBtnDose:(id)sender;


@end
