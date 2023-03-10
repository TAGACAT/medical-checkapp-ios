//
//  CustomMeasureConfTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "PickerViewDate.h"
#import "OSP_DateManager.h"

@interface CustomMeasureConfTestViewController : UIViewController{
    
    IBOutlet UIButton *btnTime;

    IBOutlet UILabel *lblTitulo;
    
    TestScheduleCustomMeasureBE *objTimeTakeBE;
    NSString *NombreTitulo;
    
}

@property (readwrite, retain) TestScheduleCustomMeasureBE *objTimeTakeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicBntTime:(id)sender;


@end
