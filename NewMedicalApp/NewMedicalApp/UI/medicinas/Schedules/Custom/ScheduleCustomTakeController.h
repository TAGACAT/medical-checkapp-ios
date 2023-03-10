//
//  ScheduleCustomTakeController.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "ScheduleConfigurarCustomTakeController.h"


@interface ScheduleCustomTakeController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *arrayTomas;
    
    IBOutlet UITableView *tlbTomas;

    
    NSString *NombreTitulo;
    
    IBOutlet UIView *viewConTomas;
    IBOutlet UIView *viewSinTomas;
}

@property (readwrite, retain) NSString *NombreTitulo;
@property (readwrite, retain) NSMutableArray *arrayTomas;

-(IBAction)Agregar:(id)Sender;

@end
