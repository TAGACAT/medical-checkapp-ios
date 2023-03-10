//
//  PickerViewNumber.h
//  MedicalCheckApp
//
//

#import <UIKit/UIKit.h>

@interface PickerViewNumber : UIView <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIPickerView *_myPickerView;
    NSMutableArray *arrayPicker;
    UIImageView *imgFondo;
    
    NSString *NombreNotificacion;
    int NumeroColumnas;
    int ValorMinimo;
}

@property (readwrite) int ValorMinimo;
@property (readwrite, retain) NSString *NombreNotificacion;
@property (readwrite) int NumeroColumnas;
@property (readwrite) int seleccion;

-(void)MostrarPickerView;
-(void)OcultarPickerView;
-(void)CrearElementos;

@end
