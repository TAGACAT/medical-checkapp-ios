//
//  RefillAlarmViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RefillAlarmViewController.h"

@interface RefillAlarmViewController ()

@end

@implementation RefillAlarmViewController
@synthesize objMedicinaBE;


- (void)ActualizarTriggerLeft:(NSNotification *)notification{
    
    [btnPills setTitle:[NSString stringWithFormat:@"%d",[((NSNumber *)[notification object])intValue]] forState:0];
    [objMedicinaBE setTriggerUnitsLeft:[notification object]];
}


-(IBAction)clicbtnPills:(id)sender{
    
    PickerViewNumber *myPicker = [[PickerViewNumber alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setNombreNotificacion:@"ActualizarTriggerLeft"];
    [myPicker setNumeroColumnas:2];
    [myPicker setValorMinimo:[objMedicinaBE.packageSize intValue]];
    [myPicker setSeleccion:[objMedicinaBE.triggerUnitsLeft intValue]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
}


-(IBAction)changeValueAlarma:(id)sender{

    [objMedicinaBE setRefillAlarm:[NSNumber numberWithBool:swcAlarma.on]];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarTriggerLeft:) name:@"ActualizarTriggerLeft" object:nil];
    
    self.title = @"Refill Alarm";
    lblTitulo.text = objMedicinaBE.drugName;
    [swcAlarma setOn:[objMedicinaBE.refillAlarm boolValue]];
    [btnPills setTitle:[NSString stringWithFormat:@"%d",[objMedicinaBE.triggerUnitsLeft intValue]] forState:0];
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
    [objMedicinaBE release];
    [super dealloc];
}


@end
