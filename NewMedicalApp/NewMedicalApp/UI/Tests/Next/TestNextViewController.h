//
//  TestNextViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "OSP_DateManager.h"
#import "Test.h"
#import "TestNextDetailViewController.h"
#import "MBProgressHUD.h"

@interface TestNextViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UISegmentedControl *mySegmented;
    IBOutlet UITableView *myTable;
    
    NSMutableArray *ArrayTable;
    NSMutableArray *ArrayNotificaciones;
    Test *aTest;
    
    MBProgressHUD *hud;
}

@property (readwrite, retain) Test *aTest;
@property (readwrite, retain) NSMutableArray *ArrayTable;
@property (readwrite, retain) NSMutableArray *ArrayNotificaciones;

-(IBAction) segmentedControlIndexChanged:(UISegmentedControl *)sender;

@end
