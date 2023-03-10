//
//  TestNextDetailViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "Notificaciones.h"
#import "OSP_DateManager.h"
#import "Test.h"

@interface TestNextDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *ArrayDetalle;
}

@property (readwrite, retain) NSMutableArray *ArrayDetalle;

@end
