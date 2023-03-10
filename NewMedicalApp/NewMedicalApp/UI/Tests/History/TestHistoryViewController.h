//
//  TestHistoryViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "MBProgressHUD.h"
#import "TestHistoryDetailViewController.h"
#import "TestHistoryGraficaView.h"

@interface TestHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UISegmentedControl *mySegmentedControl;
    IBOutlet UISegmentedControl *mySegmentedControlVista;
    IBOutlet UITableView *myTableView;
    
    Test *objTest;
    
    NSMutableArray *arrayHistory;
    NSMutableArray *ArrayTable;
    
    MBProgressHUD *hud;
    
    IBOutlet TestHistoryGraficaView *MyGrafico;
}

@property (readwrite, retain) Test *objTest;
@property (readwrite, retain) NSMutableArray *arrayHistory;
@property (readwrite, retain) NSMutableArray *ArrayTable;

-(IBAction)SelecteIndex:(id)sender;
-(IBAction)SleccionVista:(id)sender;

@end
