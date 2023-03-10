//
//  VistaTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>

#import "HeaderTestBE.h"
#import "HeaderTestDALC.h"
#import "PickerViewList.h"

#import "NotificacionesDALC.h"
#import "MBProgressHUD.h"

#import "ScheduleTimeTestViewController.h"
#import "ScheduleIntervalTestViewController.h"
#import "CustomTestViewController.h"

@interface VistaTestViewController : UIViewController<UIAlertViewDelegate>{
    
    IBOutlet UILabel *lblNombreMedicina;
    
    IBOutlet UIButton *btnSeleccionScheduleTime;
    
    NSMutableArray *arrayTiposScheduleTime;
    
    Test *objTest;
    
    TestBE *objTestBE;
    BOOL modifico;
    
    MBProgressHUD *hud;
 
    IBOutlet UIButton *btnConfigurar;
}

@property (readwrite, retain) NSMutableArray *arrayTiposScheduleTime;
@property (readwrite, retain) TestBE *objTestBE;
@property (readwrite, retain) Test *objTest;


-(IBAction)ClicSeleccionScheduleTime:(id)sender;
-(IBAction)ClicConFigurarScheduleTime:(id)sender;


@end
