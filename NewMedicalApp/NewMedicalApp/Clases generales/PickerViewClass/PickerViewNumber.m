//
//  PickerViewNumber.m
//  MedicalCheckApp
//
//

#import "PickerViewNumber.h"
#import "Math.h"

@implementation PickerViewNumber

@synthesize NombreNotificacion;
@synthesize NumeroColumnas;
@synthesize ValorMinimo;
@synthesize seleccion;

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


-(NSNumber *)SeleccionEnPicker{
    
    NSMutableArray *arrayNumeros = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < NumeroColumnas; i++) 
        [arrayNumeros insertObject:[[arrayPicker objectAtIndex:i] objectAtIndex:[_myPickerView selectedRowInComponent:i]] atIndex:0];

    int numeroFinal = 0;
    
    for (int i = [arrayNumeros count] - 1; i >= 0; i--) {
        numeroFinal+= [[arrayNumeros objectAtIndex:i] intValue] * pow(10, i);                                                                                                                                                                                                                        
    }
    
    return [NSNumber numberWithInt:numeroFinal];
}


#pragma mark -
#pragma mark pickerView Delegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [arrayPicker count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    return [[arrayPicker objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return (NSString *)[[arrayPicker objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSNumber *seleccionPic = [self SeleccionEnPicker]; 
    [[NSNotificationCenter defaultCenter] postNotificationName:NombreNotificacion object:seleccionPic];

}



#pragma mark -


-(NSArray *)arrayValores:(int)Valor{
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:Valor/10],[NSNumber numberWithInt:Valor%10], nil];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)CrearElementos{
    
   
    arrayPicker = [[NSMutableArray alloc] init];
    
    if (NumeroColumnas == 1) {
        
        NSMutableArray *arrayNum = [[[NSMutableArray alloc] init] autorelease];
        for (int i = 0; i < ValorMinimo; i++) 
            [arrayNum addObject:[NSString stringWithFormat:@"%d",1+i]];
        [arrayPicker addObject:arrayNum];
        
    }else {
        for (int i = 0; i < NumeroColumnas; i++) 
            [arrayPicker addObject:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
    }
    
    
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
    
    
    if (NumeroColumnas == 1) {
        [_myPickerView selectRow:seleccion-1 inComponent:0 animated:YES];
    }else {
        [_myPickerView selectRow:[[[self arrayValores:seleccion] objectAtIndex:0] intValue] inComponent:0 animated:YES];
        [_myPickerView selectRow:[[[self arrayValores:seleccion] objectAtIndex:1] intValue] inComponent:1 animated:YES];
    }
    
    

}   

-(void)dealloc{
    
    [NombreNotificacion release];
    [imgFondo release];
    [arrayPicker release];
    [_myPickerView release];
    [super dealloc];
}


@end
