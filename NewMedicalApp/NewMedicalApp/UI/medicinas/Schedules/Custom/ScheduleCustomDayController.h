//
//  ScheduleCustomDayController.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeaderDrugBE.h"
#import "ScheduleCustomTakeController.h"


@interface ScheduleCustomDayController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *tblDias;
    NSString *NombreTitulo;
    
    NSArray *arrayDias;
}

@property (readwrite, retain) NSArray *arrayDias;
@property (readwrite, retain) NSString *NombreTitulo;

@end
