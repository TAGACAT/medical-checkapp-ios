//
//  ScheduleConfigurarCustomTakeController.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "ScheduleConfigurarCustomTakeController.h"



@implementation ScheduleConfigurarCustomTakeController

@synthesize objTimeTakeBE;
@synthesize NombreTitulo;


-(IBAction)ClicBntTime:(id)sender{
    
    PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setModoPickerViewDate:3];
    [myPicker setNombreNotificacion:@"botonTimeCustomTake"];
    [myPicker setFechaPicker:[OSP_DateManager CombinaHoras:objTimeTakeBE.time conFecha:[NSDate date] en24horas:YES conSisHorario:nil]];
    [myPicker setFechaMinima:nil];
    [myPicker setIntervaloMinutos:[NSNumber numberWithInt:15]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarDatePickerView];
    [myPicker release];
}

-(IBAction)ClicBtnDose:(id)sender{
    
    NSMutableArray *arrayMedidasPills = [[NSMutableArray alloc] init];
    
    [arrayMedidasPills addObject:@"0"];
    [arrayMedidasPills addObject:@"1/4"];
    [arrayMedidasPills addObject:@"1/3"];    
    [arrayMedidasPills addObject:@"1/2"];
    [arrayMedidasPills addObject:@"2/3"];
    [arrayMedidasPills addObject:@"3/4"];
    
    NSMutableArray *arrayMedidasFlotantesPills = [[NSMutableArray alloc] init];
    
    [arrayMedidasFlotantesPills addObject:@"0"];
    [arrayMedidasFlotantesPills addObject:@"1"];
    [arrayMedidasFlotantesPills addObject:@"2"];    
    [arrayMedidasFlotantesPills addObject:@"3"];
    [arrayMedidasFlotantesPills addObject:@"4"];
    
    PickerViewList *myPicker = [[PickerViewList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setNombreNotificacion:@"botonDoseCustomTake"];
    [myPicker setSeleccion:((UIView *)sender).tag];
    [myPicker setArrayPicker:[NSArray arrayWithObjects:arrayMedidasFlotantesPills,arrayMedidasPills,nil]];
    [myPicker setValorMinimo:objTimeTakeBE.dose];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
    
    [arrayMedidasPills release];
    [arrayMedidasFlotantesPills release];
    
}


#pragma mark -
#pragma mark - Eventos notificaciones

-(void)botonTimeCustomTake:(NSNotification *)notification{
    
    [btnTime setTitle:[notification object] forState:0];
    [objTimeTakeBE setTime:[notification object]];
}


-(void)botonDoseCustomTake:(NSNotification *)notification{
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[[notification object] floatValue]] forState:0];
    [objTimeTakeBE setDose:[notification object]];
}


#pragma mark -


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Edit";
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonTimeCustomTake:) name:@"botonTimeCustomTake" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonDoseCustomTake:) name:@"botonDoseCustomTake" object:nil];
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[objTimeTakeBE.dose floatValue]] forState:0];
    [btnTime setTitle:objTimeTakeBE.time forState:0];
    [lblTitulo setText:NombreTitulo];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    
    [NombreTitulo release];
    [objTimeTakeBE release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
