//
//  MeasureViewController.h
//  NewMedicalApp
//
//
//

#import <UIKit/UIKit.h>
#import "NotificacionesDALC.h"
#import "Notificaciones.h"
#import "OSP_DateManager.h"
#import "Test.h"

//#define CHARACTERS_NUMBERS_MEASURE  @"1234567890."

@interface MeasureViewController : UIViewController <UITextFieldDelegate>{
    
    Notificaciones *objNoti;
    
    IBOutlet UIButton *btnDoses;
    IBOutlet UIButton *btnTime;
    IBOutlet UIButton *btnNext;
    
    IBOutlet UITextField *txtDose;
    
    int modo;
    
    NSMutableArray *arrayComentarios;
}

@property (readwrite, retain) NSMutableArray *arrayComentarios;
@property (readwrite, retain) Notificaciones *objNoti;
@property (readwrite) int modo;


-(IBAction)clicDose:(id)sender;
-(IBAction)clicSkype:(id)sender;
-(IBAction)clicSave:(id)sender;
-(IBAction)clicComments:(id)sender;


@end
