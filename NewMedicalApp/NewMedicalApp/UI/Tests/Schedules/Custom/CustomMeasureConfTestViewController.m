//
//  CustomMeasureConfTestViewController.m
//  NewMedicalApp
//
//
//

#import "CustomMeasureConfTestViewController.h"

@interface CustomMeasureConfTestViewController ()

@end

@implementation CustomMeasureConfTestViewController
@synthesize objTimeTakeBE;
@synthesize NombreTitulo;


-(IBAction)ClicBntTime:(id)sender{
    
    PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setModoPickerViewDate:3];
    [myPicker setFechaPicker:[OSP_DateManager CombinaHoras:objTimeTakeBE.time conFecha:[NSDate date] en24horas:YES conSisHorario:nil]];
    [myPicker setNombreNotificacion:@"botonTimeCustomTakeTest"];
    [myPicker setFechaMinima:nil];
    [myPicker setIntervaloMinutos:[NSNumber numberWithInt:15]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarDatePickerView];
    [myPicker release];
}



#pragma mark -
#pragma mark - Eventos notificaciones

-(void)botonTimeCustomTakeTest:(NSNotification *)notification{
    
    [btnTime setTitle:[notification object] forState:0];
    [objTimeTakeBE setTime:[notification object]];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonTimeCustomTakeTest:) name:@"botonTimeCustomTakeTest" object:nil];
    
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
