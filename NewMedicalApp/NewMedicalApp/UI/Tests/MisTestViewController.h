//
//  MisTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>

#import "HeaderTestDALC.h"
#import "MenuTestViewController.h"
#import "BuscarTestViewController.h"

@interface MisTestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *arrayTest;
    
    IBOutlet UITableView *myTable;
    
    IBOutlet UIView *viewConMedicinas;
    IBOutlet UIView *viewSinMedicinas;
    
     BOOL hacerPush;
}

@property (readwrite, retain) NSMutableArray *arrayTest;
@property (readwrite) BOOL hacerPush;

-(IBAction)BuscarParaAgregar:(id)Sender;

@end
