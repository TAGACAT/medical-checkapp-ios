//
//  PickerViewDate.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewDate : UIView {
    
    UIDatePicker *_PickerView;
    UIImageView *imgFondo;
    NSString *NombreNotificacion;
    
    NSDate *FechaMinima;
    NSNumber *intervaloMinutos;
    
    int modoPickerViewDate;
    //0 = UIDatePickerModeTime 1 =  UIDatePickerModeDate 2 = UIDatePickerModeDateAndTime 3 = UIDatePickerModeCountDownTimer
}

@property (readwrite, retain) NSNumber *intervaloMinutos;
@property (readwrite, retain) NSDate *FechaMinima;
@property (readwrite, retain) NSDate *FechaPicker;
@property (readwrite, retain) NSString *NombreNotificacion;
@property (readwrite) int modoPickerViewDate;

-(void)MostrarDatePickerView;
-(void)OcultarDatePickerView;
-(void)CrearElementos;

@end
