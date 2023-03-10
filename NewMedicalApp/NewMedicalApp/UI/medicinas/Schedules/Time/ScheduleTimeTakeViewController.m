//
//  ScheduleTimeTakeViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleTimeTakeViewController.h"

@interface ScheduleTimeTakeViewController ()

@end

@implementation ScheduleTimeTakeViewController
@synthesize objTimeTakeBE;
@synthesize NombreTitulo;


#pragma mark -
#pragma mark - Eventos notificaciones

-(void)botonTimeTakeMeds:(NSNotification *)notification{
    
    [btnTime setTitle:[notification object] forState:0];
    [objTimeTakeBE setTime:[notification object]];
}


-(void)botonDoseTakeMeds:(NSNotification *)notification{
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[[notification object] floatValue]] forState:0];
    [objTimeTakeBE setDose:[notification object]];
}


#pragma mark -


-(IBAction)ClicBntTime:(id)sender{
    
    PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setModoPickerViewDate:3];
    [myPicker setNombreNotificacion:@"botonTimeTakeMeds"];
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
    [myPicker setNombreNotificacion:@"botonDoseTakeMeds"];
    [myPicker setSeleccion:((UIView *)sender).tag];
    [myPicker setValorMinimo:objTimeTakeBE.dose];
    [myPicker setArrayPicker:[NSArray arrayWithObjects:arrayMedidasFlotantesPills,arrayMedidasPills,nil]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
    
    [arrayMedidasPills release];
    [arrayMedidasFlotantesPills release];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Edit";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonTimeTakeMeds:) name:@"botonTimeTakeMeds" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonDoseTakeMeds:) name:@"botonDoseTakeMeds" object:nil];
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[objTimeTakeBE.dose floatValue]] forState:0];
    [btnTime setTitle:objTimeTakeBE.time forState:0];
    [lblTitulo setText:NombreTitulo];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [objTimeTakeBE release];
    [NombreTitulo release];
    [super dealloc];
}

@end
