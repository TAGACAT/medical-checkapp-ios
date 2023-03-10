//
//  ScheduleIntervalMedicinasViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleIntervalMedicinasViewController.h"

@interface ScheduleIntervalMedicinasViewController ()

@end

@implementation ScheduleIntervalMedicinasViewController
@synthesize objIntervalBE;
@synthesize NombreTitulo;
@synthesize numberMayor;
@synthesize numberMenor;
@synthesize intervalArrayNumber;
@synthesize intervalArrayString;


-(void)createIntervalArray{
    if([intervalArrayString count]>0)
        [intervalArrayString removeAllObjects];
    if([intervalArrayNumber count]>0)
        [intervalArrayNumber removeAllObjects];
    int rango;
    if(btnInterruption.on)
        rango=[numberMayor intValue]-[numberMenor intValue]; 
    else
        rango = 24-[numberMenor intValue];
    for(int i=0;i<rango;i++)
    {
        [intervalArrayNumber insertObject:[NSNumber numberWithInt:i+1] atIndex:i];
        [intervalArrayString insertObject:[NSString stringWithFormat:@"%d hours",i+1] atIndex:i];
    }
}

-(NSInteger)ConvertDateToNumberHour:(NSString *)cadena{
    NSArray *listItems = [cadena componentsSeparatedByString:@":"];
    NSNumberFormatter * f = [[[NSNumberFormatter alloc] init] autorelease];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[listItems objectAtIndex:0]]; 
    return [myNumber integerValue];
}

-(NSInteger)ConvertDateToNumberMinute:(NSString *)cadena{
    NSArray *listItems = [cadena componentsSeparatedByString:@":"];
    NSNumberFormatter * f = [[[NSNumberFormatter alloc] init] autorelease];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[listItems objectAtIndex:1]]; 
    return [myNumber integerValue];
}

-(void)StringToNumber:(NSString *)cadena1 andCadena2:(NSString *)cadena2{
    NSArray *listItems = [cadena1 componentsSeparatedByString:@":"];
    NSNumberFormatter * f = [[[NSNumberFormatter alloc] init] autorelease];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[listItems objectAtIndex:0]];
    [self setNumberMenor:myNumber];
    
    listItems = [cadena2 componentsSeparatedByString:@":"];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    myNumber = [f numberFromString:[listItems objectAtIndex:0]];
    [self setNumberMayor:myNumber];
    
    NSLog(@"NumberMenor:%d, NumberMayor:%d",[numberMenor intValue],[numberMayor intValue]);
    
    [self createIntervalArray];
}


#pragma mark - notificaciones

-(void)FechaBotonStartIntervalosMedicina:(NSNotification *)notification{
    
    [btnStartDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    [objIntervalBE setStartDate:[notification object]];
    
}


-(void)FechaBotonEndIntervalosMedicina:(NSNotification *)notification{
    
    if ([notification object] == nil) {
        [btnEndDate setTitle:@"Never" forState:0];
    }else {
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    }
    
    [objIntervalBE setEndDate:[notification object]];
}


-(void)botonDoseIntervalMeds:(NSNotification *)notification{
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[[notification object] floatValue]] forState:0];
    [objIntervalBE setDose:[notification object]];
}


-(void)ActualizarIntervalHoras:(NSNotification *)notification{
    
    [btnInterval setTitle:[[notification object] objectAtIndex:0] forState:0];
    [objIntervalBE setInterval:[[notification object] objectAtIndex:1]];
    
}


-(void)botonFristTakeInterval:(NSNotification *)notification{
    
    [btnFristTake setTitle:[notification object] forState:0];
    [objIntervalBE setFirstIntake:[notification object]];
    
    [self StringToNumber:btnFristTake.titleLabel.text andCadena2:btnBedTime.titleLabel.text];
}

-(void)botonBedTimeInterval:(NSNotification *)notification{
    
    [btnBedTime setTitle:[notification object] forState:0];
    [objIntervalBE setBedTime:[notification object]];
    
    [self StringToNumber:btnFristTake.titleLabel.text andCadena2:btnBedTime.titleLabel.text];
}


#pragma mark - eventos clic

-(IBAction)clicBtnStartDate:(id)sender{
    
    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    kal.title = @"Start Date";
    [kal setModo:0];
    [kal setNombreNotificacion:@"FechaBotonStartIntervalosMedicina"];
    [self.navigationController pushViewController:kal animated:YES];
}


-(IBAction)clicBtnEndDate:(id)sender{

    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    
    kal.title = @"End Date";
    [kal setModo:1];
    [kal setNombreNotificacion:@"FechaBotonEndIntervalosMedicina"];
    
//    if (objIntervalBE.endDate != nil) {
//        [kal showAndSelectDate:objIntervalBE.endDate];
//    }else {
//        [kal showAndSelectDate:[objIntervalBE.startDate dateByAddingTimeInterval:60*60*24]];
//    }
    
    [self.navigationController pushViewController:kal animated:YES];
}


-(IBAction)clicBtnDose:(id)sender{
    
    NSMutableArray *arrayMedidasPills = [[[NSMutableArray alloc] init] autorelease];
    
    [arrayMedidasPills addObject:@"0"];
    [arrayMedidasPills addObject:@"1/4"];
    [arrayMedidasPills addObject:@"1/3"];    
    [arrayMedidasPills addObject:@"1/2"];
    [arrayMedidasPills addObject:@"2/3"];
    [arrayMedidasPills addObject:@"3/4"];
    
    NSMutableArray *arrayMedidasFlotantesPills = [[[NSMutableArray alloc] init] autorelease];
    
    [arrayMedidasFlotantesPills addObject:@"0"];
    [arrayMedidasFlotantesPills addObject:@"1"];
    [arrayMedidasFlotantesPills addObject:@"2"];    
    [arrayMedidasFlotantesPills addObject:@"3"];
    [arrayMedidasFlotantesPills addObject:@"4"];
    
    PickerViewList *myPicker = [[[PickerViewList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    [myPicker setNombreNotificacion:@"botonDoseIntervalMeds"];
    [myPicker setSeleccion:((UIView *)sender).tag];
    [myPicker setArrayPicker:[NSArray arrayWithObjects:arrayMedidasFlotantesPills,arrayMedidasPills,nil]];
    [myPicker setValorMinimo:objIntervalBE.dose];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];

    
}


-(IBAction)clicBtnInterval:(id)sender{

    PickerViewInterval *myPicker = [[PickerViewInterval alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setNombreNotificacion:@"ActualizarIntervalHoras"];
    [myPicker setSeleccion:((UIView *)sender).tag];
    NSLog(@"CountStringArray:%d",[intervalArrayString count]);
    NSLog(@"CountNumberArray:%d",[intervalArrayNumber count]);
    [myPicker setArrayString:[NSArray arrayWithObject:intervalArrayString]];
    [myPicker setArrayNumber:[NSArray arrayWithObject:intervalArrayNumber]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
    
}


-(IBAction)clicBtnFristTake:(id)sender{
    
    PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setModoPickerViewDate:3];
    [myPicker setNombreNotificacion:@"botonFristTakeInterval"];
    [myPicker setFechaPicker:[OSP_DateManager CombinaHoras:objIntervalBE.firstIntake conFecha:[NSDate date] en24horas:YES conSisHorario:nil]];
    [myPicker setFechaMinima:nil];
    [myPicker setIntervaloMinutos:[NSNumber numberWithInt:15]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarDatePickerView];
    [myPicker release];
    
    [objIntervalBE setInterval:[NSNumber numberWithInt:1]];
    [btnInterval setTitle:[NSString stringWithFormat:@"%@ Hours",objIntervalBE.interval] forState:0];

}


-(IBAction)clicBtnInterruption:(id)sender{


    if (btnInterruption.on) {
        [objIntervalBE setInteruption:[NSNumber numberWithInt:1]];
        [self StringToNumber:btnFristTake.titleLabel.text andCadena2:btnBedTime.titleLabel.text];
        [objIntervalBE setInterval:[NSNumber numberWithInt:1]];
        [btnInterval setTitle:[NSString stringWithFormat:@"%@ Hours",objIntervalBE.interval] forState:0];
        btnBedTime.alpha = 1;
    }else {
        [objIntervalBE setInteruption:[NSNumber numberWithInt:0]];
        [self StringToNumber:btnFristTake.titleLabel.text andCadena2:btnBedTime.titleLabel.text];
        [objIntervalBE setInterval:[NSNumber numberWithInt:1]];
        [btnInterval setTitle:[NSString stringWithFormat:@"%@ Hours",objIntervalBE.interval] forState:0];
        btnBedTime.alpha = 0.5;
    }
}


-(IBAction)clicBtnBebTime:(id)sender{
    
    if(btnInterruption.on){
        
        NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
        [comps setHour:[self ConvertDateToNumberHour:[objIntervalBE firstIntake]]+1];
        [comps setMinute:[self ConvertDateToNumberMinute:[objIntervalBE firstIntake]]];
        
        NSCalendar *cal = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        NSDate *referenceTime = [cal dateFromComponents:comps];
        
        NSLog(@"%@",referenceTime);
        
        PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [myPicker setModoPickerViewDate:3];
        [myPicker setNombreNotificacion:@"botonBedTimeInterval"];
        [myPicker setFechaPicker:[OSP_DateManager CombinaHoras:objIntervalBE.bedTime conFecha:[NSDate date] en24horas:YES conSisHorario:nil]];
        [myPicker setFechaMinima:referenceTime];
        [myPicker setIntervaloMinutos:[NSNumber numberWithInt:15]];
        [myPicker CrearElementos];
        [self.view addSubview:myPicker];
        [myPicker MostrarDatePickerView];
        [myPicker release];
        
        
        [objIntervalBE setInterval:[NSNumber numberWithInt:1]];
        [btnInterval setTitle:[NSString stringWithFormat:@"%@ Hours",objIntervalBE.interval] forState:0];
    }
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FechaBotonStartIntervalosMedicina:) name:@"FechaBotonStartIntervalosMedicina" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FechaBotonEndIntervalosMedicina:) name:@"FechaBotonEndIntervalosMedicina" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonDoseIntervalMeds:) name:@"botonDoseIntervalMeds" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarIntervalHoras:) name:@"ActualizarIntervalHoras" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonFristTakeInterval:) name:@"botonFristTakeInterval" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonBedTimeInterval:) name:@"botonBedTimeInterval" object:nil];
    
    
    [self setIntervalArrayNumber:[[[NSMutableArray alloc] init] autorelease]];
    [self setIntervalArrayString:[[[NSMutableArray alloc] init] autorelease]];
    
    [lblTitulo setText:NombreTitulo];
    
    [btnStartDate setTitle:[OSP_DateManager CambiaFecha:objIntervalBE.startDate AlFormato:@"MMM, dd yyyy"] forState:0];
    if (objIntervalBE.endDate) 
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:objIntervalBE.endDate AlFormato:@"MMM, dd yyyy"] forState:0];
    
    
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[objIntervalBE.dose floatValue]] forState:0];
    [btnInterval setTitle:[NSString stringWithFormat:@"%@ Hours",objIntervalBE.interval] forState:0];
    [btnFristTake setTitle:objIntervalBE.firstIntake forState:0];
    [btnBedTime setTitle:objIntervalBE.bedTime forState:0];
    
    
    
    if ([objIntervalBE.interuption intValue] == 1) {
        btnInterruption.on = YES;
        btnBedTime.alpha = 1;
    }
    else{
        btnInterruption.on = NO;
        btnBedTime.alpha = 0.5;
    }
        
    
    [self StringToNumber:btnFristTake.titleLabel.text andCadena2:btnBedTime.titleLabel.text];

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
    [objIntervalBE release];
    [NombreTitulo release];
    [super dealloc];
}

@end
