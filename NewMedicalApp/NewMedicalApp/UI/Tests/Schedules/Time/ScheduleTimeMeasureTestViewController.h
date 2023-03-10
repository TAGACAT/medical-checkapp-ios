//
//  ScheduleTimeMeasureTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>

#import "HeaderTestBE.h"
#import "PickerViewDate.h"
#import "PickerViewList.h"
#import "OSP_DateManager.h"

@interface ScheduleTimeMeasureTestViewController : UIViewController{
    
    IBOutlet UIButton *btnTime;
    IBOutlet UILabel *lblTitulo;
    
    TestScheduleTimeMeasureBE *objTimeTakeBE;
    NSString *NombreTitulo;
    
}

@property (readwrite, retain) TestScheduleTimeMeasureBE *objTimeTakeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicBntTime:(id)sender;


@end
