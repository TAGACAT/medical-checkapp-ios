//
//  CustomTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "PickerViewDate.h"
#import "OSP_DateManager.h"
#import "PickerViewNumber.h"
#import "CustomDayTestViewController.h"
#import "HeaderTestBE.h"
#import "KalViewController.h"

@interface CustomTestViewController : UIViewController{
    
    NSString *NombreTitulo;
    
    IBOutlet UILabel *lblTitulo;
    IBOutlet UIButton *btnStarDate;
    IBOutlet UIButton *btnEndDate;
    IBOutlet UIButton *btnNoDays;
    IBOutlet UIButton *btnConfigurar;
    
    TestScheduleCustomBE *objScheduleCustomBE;
}

@property (readwrite, retain) NSString *NombreTitulo;
@property (readwrite, retain) TestScheduleCustomBE *objScheduleCustomBE;


-(IBAction)ClicStarDate:(id)sender;
-(IBAction)ClicEndDate:(id)sender;
-(IBAction)ClicNoDays:(id)sender;

-(IBAction)ClicCustomDays:(id)sender;

@end
