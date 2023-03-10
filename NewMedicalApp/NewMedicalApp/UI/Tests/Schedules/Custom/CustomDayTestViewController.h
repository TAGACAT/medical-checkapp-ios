//
//  CustomDayTestViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "HeaderTestBE.h"
#import "CustomMeasureTestViewController.h"


@interface CustomDayTestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *tblDias;
    NSString *NombreTitulo;
    
    NSArray *arrayDias;
}

@property (readwrite, retain) NSArray *arrayDias;
@property (readwrite, retain) NSString *NombreTitulo;

@end
