//
//  ScheduleTimeViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "ScheduleTimeTakeViewController.h"
#import "OSP_DateManager.h"
#import "KalViewController.h"


@interface ScheduleTimeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UILabel *lblTitulo;
    NSString *NombreTitulo;
    
    ScheduleTimeBE *objScheduleTimeBE;
    
    IBOutlet UIButton *btnStartDate;
    IBOutlet UIButton *btnEndDate;
    
    IBOutlet UITableView *_TableView;
    
}

@property (readwrite, retain) ScheduleTimeBE *objScheduleTimeBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(IBAction)ClicStartDate:(UIButton *)sender;
-(IBAction)ClicEndDate:(UIButton *)sender;


@end
