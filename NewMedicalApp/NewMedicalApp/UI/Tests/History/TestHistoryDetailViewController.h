//
//  TestHistoryDetailViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>

#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "OSP_DateManager.h"
#import "ListaComentariosViewController.h"

@interface TestHistoryDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UIButton *btnDose;
    IBOutlet UIButton *btnDate;
    
    Notificaciones *objNotificacion;
    
    NSMutableArray *arrayTable;
    IBOutlet UITableView *tblComentarios;
    IBOutlet UILabel *lblNoComments;
}

@property (readwrite, retain) NSMutableArray *arrayTable;
@property (readwrite, retain) Notificaciones *objNotificacion;

-(IBAction)clicComent:(id)sender;

@end
