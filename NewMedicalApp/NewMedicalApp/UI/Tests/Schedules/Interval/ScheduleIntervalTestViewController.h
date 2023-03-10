//
//  ScheduleIntervalTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "KalViewController.h"
#import "OSP_DateManager.h"
#import "PickerViewList.h"
#import "PickerViewInterval.h"
#import "PickerViewDate.h"



@interface ScheduleIntervalTestViewController : UIViewController{
    
    
    IBOutlet UIButton *btnStartDate;
    IBOutlet UIButton *btnEndDate;
    IBOutlet UIButton *btnInterval;
    IBOutlet UIButton *btnFristTake;
    IBOutlet UISwitch *btnInterruption;
    IBOutlet UIButton *btnBedTime;
    
    IBOutlet UILabel *lblTitulo;
    
    TestScheduleIntervalBE *objIntervalBE;
    NSString *NombreTitulo;
    
    NSNumber *numberMenor;
    NSNumber *numberMayor;
    NSMutableArray *intervalArrayNumber;
    NSMutableArray *intervalArrayString;
    
}

@property (readwrite, retain) NSString *NombreTitulo;
@property (readwrite, retain) NSNumber *numberMenor;
@property (readwrite, retain) NSNumber *numberMayor;
@property (readwrite, retain) TestScheduleIntervalBE *objIntervalBE;
@property (readwrite, retain) NSMutableArray *intervalArrayNumber;
@property (readwrite, retain) NSMutableArray *intervalArrayString;

-(IBAction)clicBtnStartDate:(id)sender;
-(IBAction)clicBtnEndDate:(id)sender;
-(IBAction)clicBtnInterval:(id)sender;
-(IBAction)clicBtnFristTake:(id)sender;
-(IBAction)clicBtnInterruption:(id)sender;
-(IBAction)clicBtnBebTime:(id)sender;

@end
