//
//  PackageSizeViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDrugBE.h"
#import "HeaderDrugDALC.h"

@interface PackageSizeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    IBOutlet UILabel *lblTitulo;
    IBOutlet UIPickerView *pkView;
    IBOutlet UIButton *btnCantidad;
    
    NSString *NombreTitulo;
    NSMutableArray *arrayPicker;
    int cantidadSeleccion;
    
    MedicinaBE *objMedicinaBE;
}

@property (readwrite, retain) MedicinaBE *objMedicinaBE;
@property (readwrite, retain) NSString *NombreTitulo;

-(void)CrearNuevaMedicina:(MedicinaBE *)aMedicina;

@end
