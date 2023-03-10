//
//  NuevaMedicinaViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackageSizeViewController.h"
#import "HeaderDrugBE.h"

@interface NuevaMedicinaViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>{
    
    IBOutlet UITextField *txtNombre;
    IBOutlet UITextField *txtForm;
    
    NSString *NombreMedicina;
    NSMutableArray *arrayPicker;
}

@property (readwrite, retain) NSString *NombreMedicina;

@end
