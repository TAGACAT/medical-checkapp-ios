//
//  MenuTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "HeaderTestDALC.h"
#import "TestNextViewController.h"
#import "VistaTestViewController.h"
#import "TestHistoryViewController.h"

@interface MenuTestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    Test *aTest;
    NSMutableArray *arrayTable;
    
    IBOutlet UILabel *lblTitulo;
}

@property (readwrite, retain) Test *aTest;


-(IBAction)ClicQuickIntake:(id)sender;

@end
