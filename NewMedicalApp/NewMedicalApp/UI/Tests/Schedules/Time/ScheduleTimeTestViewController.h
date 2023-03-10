//
//  ScheduleTimeTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "OSP_DateManager.h"
#import "KalViewController.h"
#import "ScheduleTimeMeasureTestViewController.h"


@interface ScheduleTimeTestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UILabel *lblTitulo;
    NSString *NombreTitulo;
    
    TestScheduleTimeBE *objScheduleTimeBE;
    
    IBOutlet UIButton *btnStartDate;
    IBOutlet UIButton *btnEndDate;
    
    IBOutlet UITableView *_TableView;
    
}

@property (readwrite, retain) TestScheduleTimeBE *objScheduleTimeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicStartDate:(UIButton *)sender;
-(IBAction)ClicEndDate:(UIButton *)sender;

@end
