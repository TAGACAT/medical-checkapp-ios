//
//  DrugNextDetailViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notificaciones.h"
#import "OSP_DateManager.h"

@interface DrugNextDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *ArrayDetalle;
}

@property (readwrite, retain) NSMutableArray *ArrayDetalle;

@end
