//
//  BuscarTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>

#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "HeaderTestBE.h"
#import "HeaderTestDALC.h"
#import "VistaTestViewController.h"


@interface BuscarTestViewController : UIViewController <ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>{
    
    ASIFormDataRequest *arequest;
    
    MBProgressHUD *hud;

    IBOutlet UITableView *myTableView;
    
    TestBE *objTestBE;
    NSMutableArray *ArrayTest;
}

@property (readwrite, retain) NSMutableArray *ArrayTest;
@property (nonatomic, retain) ASIFormDataRequest *arequest;

@end
