//
//  DrugHistoryViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "Drug.h"
#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "MBProgressHUD.h"
#import "DrugHistoryViewDetailViewController.h"

@interface DrugHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UISegmentedControl *mySegmentedControl;
    IBOutlet UITableView *myTableView;
    
    Drug *objMedicina;
    
    NSMutableArray *arrayHistory;
    NSMutableArray *ArrayTable;
    
    MBProgressHUD *hud;
}

@property (readwrite, retain) Drug *objMedicina;
@property (readwrite, retain) NSMutableArray *arrayHistory;
@property (readwrite, retain) NSMutableArray *ArrayTable;

-(IBAction)SelecteIndex:(id)sender;

@end
