//
//  CustomMeasureTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "CustomMeasureConfTestViewController.h"

@interface CustomMeasureTestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
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
