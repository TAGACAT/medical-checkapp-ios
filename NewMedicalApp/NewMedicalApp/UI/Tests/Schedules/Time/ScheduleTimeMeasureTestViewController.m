//
//  ScheduleTimeMeasureTestViewController.m
//  NewMedicalApp
//
//
//

#import "ScheduleTimeMeasureTestViewController.h"

@interface ScheduleTimeMeasureTestViewController ()

@end

@implementation ScheduleTimeMeasureTestViewController

@synthesize objTimeTakeBE;
@synthesize NombreTitulo;


#pragma mark -
#pragma mark - Eventos notificaciones

-(void)botonTimeTakeTest:(NSNotification *)notification{
    
    [btnTime setTitle:[notification object] forState:0];
    [objTimeTakeBE setTime:[notification object]];
}


#pragma mark -


-(IBAction)ClicBntTime:(id)sender{
    
    PickerViewDate *myPicker = [[PickerViewDate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setModoPickerViewDate:3];
    [myPicker setNombreNotificacion:@"botonTimeTakeTest"];
    [myPicker setFechaPicker:[OSP_DateManager CombinaHoras:objTimeTakeBE.time conFecha:[NSDate date] en24horas:YES conSisHorario:nil]];
    [myPicker setFechaMinima:nil];
    [myPicker setIntervaloMinutos:[NSNumber numberWithInt:15]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarDatePickerView];
    [myPicker release];
    
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
    self.title = @"Edit";
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(botonTimeTakeTest:) name:@"botonTimeTakeTest" object:nil];
    
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
