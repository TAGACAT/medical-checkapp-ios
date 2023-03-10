//
//  PickerViewList.h
//  MedicalCheckApp
//
//

#import <UIKit/UIKit.h>

@interface PickerViewList : UIView <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIPickerView *_myPickerView;
    NSMutableArray *arrayPicker;
    UIImageView *imgFondo;
    
    NSString *NombreNotificacion;
    int seleccion;
    NSNumber *ValorMinimo;
}

@property (readwrite, retain) NSNumber *ValorMinimo;
@property (readwrite, retain) NSMutableArray *arrayPicker;
@property (readwrite, retain) NSString *NombreNotificacion;
@property (readwrite) int seleccion;

-(void)MostrarPickerView;
-(void)OcultarPickerView;
-(void)CrearElementos;

@end
