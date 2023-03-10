//
//  PickerViewInterval.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerViewInterval.h"

@implementation PickerViewInterval

@synthesize arrayNumber;
@synthesize arrayString;
@synthesize NombreNotificacion;
@synthesize seleccion;
@synthesize ValorMinimo;


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"entraa");
    [self OcultarPickerView];
}

-(void)OcultarPickerView{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    imgFondo.alpha = 0;
    _myPickerView.center =  CGPointMake(self.center.x, self.frame.size.height + 108); 
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animacionOcultarPicker:finished:context:)];
    [UIView commitAnimations];
}

- (void)animacionOcultarPicker:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    
    [self removeFromSuperview];
    
}


-(void)MostrarPickerView{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    _myPickerView.center =  CGPointMake(self.center.x, self.frame.size.height - 108); 
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark Eventos auxiliares

-(float)ConvierteFraccionEnFloat:(NSString *)aNumero{
    
    NSArray *aux = [NSArray arrayWithArray:[aNumero componentsSeparatedByString:@"/"]];
    if ([aux count] == 1) 
        return 0.0;
    
    return [[aux objectAtIndex:0] floatValue]/[[aux objectAtIndex:1] floatValue];
}


-(float)SeleccionEnPicker{
    
    float row1 = [[[arrayString objectAtIndex:0] objectAtIndex:[_myPickerView selectedRowInComponent:0]] floatValue];
    float row2 = [self ConvierteFraccionEnFloat:[[arrayString objectAtIndex:1] objectAtIndex:[_myPickerView selectedRowInComponent:1]]];
    
    return row1+row2;
}


#pragma mark -
#pragma mark pickerView Delegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [arrayString count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    return [[arrayString objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return (NSString *)[[arrayString objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if ([arrayString count] > 1) {
        
        float seleccionPic = [self SeleccionEnPicker];
        if (seleccionPic == [ValorMinimo floatValue]) {
            NSLog(@"Valor Minimo");
            seleccionPic = 0.25;
            [_myPickerView selectRow:1 inComponent:1 animated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NombreNotificacion object:[NSNumber numberWithFloat:seleccionPic]];
        return;
    }
    
    seleccion = row;
    [[NSNotificationCenter defaultCenter] postNotificationName:NombreNotificacion object:[NSArray arrayWithObjects:[[arrayString objectAtIndex:component] objectAtIndex:row],[[arrayNumber objectAtIndex:component] objectAtIndex:row], nil]];
}



#pragma mark -




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
    
    _myPickerView = [[UIPickerView alloc] init];
    _myPickerView.center =  CGPointMake(self.center.x, self.frame.size.height + 108); 
    _myPickerView.showsSelectionIndicator = YES;
    [self addSubview:_myPickerView];
    _myPickerView.delegate = self;
    
    if ([arrayString count] > 1) 
        [_myPickerView selectRow:1 inComponent:1 animated:YES];
    else 
        [_myPickerView selectRow:seleccion inComponent:0 animated:YES];
}   

-(void)dealloc{
    
    [ValorMinimo release];
    [NombreNotificacion release];
    [imgFondo release];
    [arrayString release];
    [arrayNumber release];
    [_myPickerView release];
    [super dealloc];
}


@end
