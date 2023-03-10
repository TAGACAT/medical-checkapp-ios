//
//  DrugHistoryViewDetailViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Notificaciones.h"
#import "NotificacionesDALC.h"
#import "OSP_DateManager.h"
#import "ListaComentariosViewController.h"

@interface DrugHistoryViewDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
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
