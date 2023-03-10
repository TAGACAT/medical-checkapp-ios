//
//  PickerViewInterval.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewInterval : UIView <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIPickerView *_myPickerView;
    NSMutableArray *arrayNumber;
    NSMutableArray *arrayString;
    UIImageView *imgFondo;
    
    NSString *NombreNotificacion;
    int seleccion;
    NSNumber *ValorMinimo;
}

@property (readwrite, retain) NSNumber *ValorMinimo;
@property (readwrite, retain) NSMutableArray *arrayNumber;
@property (readwrite, retain) NSMutableArray *arrayString;
@property (readwrite, retain) NSString *NombreNotificacion;
@property (readwrite) int seleccion;

-(void)MostrarPickerView;
-(void)OcultarPickerView;
-(void)CrearElementos;
@end
