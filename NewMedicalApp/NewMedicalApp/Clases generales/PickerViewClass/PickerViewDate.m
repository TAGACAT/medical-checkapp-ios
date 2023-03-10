//
//  PickerViewDate.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerViewDate.h"

@implementation PickerViewDate


@synthesize modoPickerViewDate;
@synthesize NombreNotificacion;
@synthesize FechaMinima;
@synthesize intervaloMinutos;
@synthesize FechaPicker;


#pragma mark -
#pragma mark funciones auxiliares

-(NSString *)DameHoraDelPicker{
    
    NSDateComponents *time = [_PickerView.calendar 
                              components:NSHourCalendarUnit | NSMinuteCalendarUnit 
                              fromDate:_PickerView.date];
    
    NSString *strHora;
    
    if ([time hour] < 10) {
        strHora = [NSString stringWithFormat:@"0%d", [time hour]];
    }else{
        strHora = [NSString stringWithFormat:@"%d", [time hour]];        
    }
    
    NSString *strMinute;
    
    if ([time minute] < 10) {
        strMinute = [NSString stringWithFormat:@"0%d", [time minute]];
    }else{
        strMinute = [NSString stringWithFormat:@"%d", [time minute]];        
    }
    
    return [NSString stringWithFormat:@"%@:%@",strHora,strMinute];
}

-(void)CambiaSeleccion:(id)Sender{
    
    if (modoPickerViewDate == 3)
        [[NSNotificationCenter defaultCenter] postNotificationName:NombreNotificacion object:[self DameHoraDelPicker]];
    else 
        [[NSNotificationCenter defaultCenter] postNotificationName:NombreNotificacion object:_PickerView.date];
}

#pragma mark -
#pragma mark funciones touch de la clase

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"entraa");
    [self OcultarDatePickerView];
}

-(void)OcultarDatePickerView{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];

    imgFondo.alpha = 0;
    _PickerView.center =  CGPointMake(self.center.x, self.frame.size.height + 108);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animacionOcultarPicker:finished:context:)];
    [UIView commitAnimations];
}

- (void)animacionOcultarPicker:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    
    [self removeFromSuperview];
}


-(void)MostrarDatePickerView{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    _PickerView.center =  CGPointMake(self.center.x, self.frame.size.height - 108); 
    [UIView commitAnimations];
}

#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)CrearElementos{
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    imgFondo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondoPickerView.png"]];
    imgFondo.center = CGPointMake(self.center.x, self.center.y);
    [self addSubview:imgFondo];
    
    imgFondo.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    imgFondo.alpha = 1;
    [UIView commitAnimations];
    NSLog(@"%@",FechaMinima);
    _PickerView = [[UIDatePicker alloc] init];
    _PickerView.center =  CGPointMake(self.center.x, self.frame.size.height + 108); 
    [_PickerView addTarget:self action:@selector(CambiaSeleccion:) forControlEvents:UIControlEventValueChanged];
    _PickerView.datePickerMode = modoPickerViewDate;
    

    if (FechaPicker) {
        _PickerView.date = FechaPicker;
        if(FechaMinima)
         _PickerView.minimumDate = FechaMinima;
    }
    

    
//    if (![intervaloMinutos isEqual:nil])
//        [_PickerView setMinuteInterval:[intervaloMinutos intValue]];
    
    [self addSubview:_PickerView];
}

-(void)dealloc{
    
    [FechaPicker release];
    [intervaloMinutos release];
    [FechaMinima release];
    [NombreNotificacion release];
    [_PickerView release];
    [imgFondo release];
    [super dealloc];
}


@end
