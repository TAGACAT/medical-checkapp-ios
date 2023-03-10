//
//  IntakeViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "NotificacionesDALC.h"
#import "Notificaciones.h"
#import "OSP_DateManager.h"
#import "Drug.h"
#import "CategoriasViewController.h"

@interface IntakeViewController : UIViewController <UITextFieldDelegate>{
    
    Notificaciones *objNoti;

    IBOutlet UIButton *btnDoses;
    IBOutlet UIButton *btnTime;
    IBOutlet UIButton *btnNext;
    
    int modo;
    
    IBOutlet UITextField *txtDosis;

    NSMutableArray *arrayComentarios;
}


@property (readwrite, retain) NSMutableArray *arrayComentarios;
@property (readwrite, retain) Notificaciones *objNoti;
@property (readwrite) int modo;

-(IBAction)clicSkype:(id)sender;
-(IBAction)clicSave:(id)sender;
-(IBAction)clicComments:(id)sender;


@end
