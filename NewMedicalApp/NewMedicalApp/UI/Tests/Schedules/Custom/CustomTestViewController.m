//
//  CustomTestViewController.m
//  NewMedicalApp
//
//
//

#import "CustomTestViewController.h"

@interface CustomTestViewController ()

@end

@implementation CustomTestViewController
@synthesize NombreTitulo;
@synthesize objScheduleCustomBE;


#pragma mark -
#pragma mark eventos notificaciones

-(void)StartCustomTest:(NSNotification *)notification{
    
    [btnStarDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    [objScheduleCustomBE setStartDate:[notification object]];
    
}

-(void)EndCustomTest:(NSNotification *)notification{
    
    if ([notification object] == nil) {
        [btnEndDate setTitle:@"Never" forState:0];
    }else {
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    }
    
    [objScheduleCustomBE setEndDate:[notification object]];
    
}

-(void)ActualizarNoDiasTest:(NSNotification *)notification{
    
    [btnNoDays setTitle:[NSString stringWithFormat:@"%d Days",[((NSNumber *)[notification object])intValue]] forState:0];
    [objScheduleCustomBE setNoMeasures:[notification object]];
    btnNoDays.tag = [((NSNumber *)[notification object])intValue];
    
    NSMutableArray *ArrayDias = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < btnNoDays.tag; i++) {
        TestScheduleCustomDayBE *CustomDayBE = [[[TestScheduleCustomDayBE alloc] init] autorelease];
        [CustomDayBE setNoDays:[NSNumber numberWithInt:1+i]];
        [CustomDayBE setDayNumber:[NSNumber numberWithInt:1+i]];
        [CustomDayBE setTestScheduleCustomMeasures:[[[NSMutableArray alloc] init] autorelease]];
        [ArrayDias addObject:CustomDayBE];
    }
    
    [objScheduleCustomBE setTestScheduleCustomDays:ArrayDias];
    
    if ([((NSNumber *)[notification object])intValue] != 0) {
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
    }else {
        btnConfigurar.enabled = NO;
        btnConfigurar.alpha = 0.7;
    }
}


#pragma mark -
#pragma mark Eventos clic

-(IBAction)ClicStarDate:(id)sender{
    
    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    
    kal.title = @"Start Date";
    [kal setModo:0];
    [kal setNombreNotificacion:@"StartCustomTest"];
    
    [self.navigationController pushViewController:kal animated:YES];
    
}

-(IBAction)ClicEndDate:(id)sender{
    
    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    
    kal.title = @"End Date";
    [kal setModo:1];
    [kal setNombreNotificacion:@"EndCustomTest"];
    
    [self.navigationController pushViewController:kal animated:YES];
    
    //    if (objScheduleCustomBE.endDate != nil) {
    //        [kal showAndSelectDate:objScheduleCustomBE.endDate];
    //    }else {
    //        [kal showAndSelectDate:[objScheduleCustomBE.startDate dateByAddingTimeInterval:60*60*24]];
    //    }
    
}

-(IBAction)ClicNoDays:(id)sender{
    
    PickerViewNumber *myPicker = [[PickerViewNumber alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setNombreNotificacion:@"ActualizarNoDiasTest"];
    [myPicker setNumeroColumnas:2];
    [myPicker setSeleccion:[objScheduleCustomBE.noMeasures intValue]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
}

-(IBAction)ClicCustomDays:(id)sender{
    
    if (btnNoDays.tag != 0) {
        CustomDayTestViewController *viewController = [[CustomDayTestViewController alloc] initWithNibName:nil bundle:nil];
        [viewController setNombreTitulo:lblTitulo.text];
        [viewController setArrayDias:objScheduleCustomBE.testScheduleCustomDays];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StartCustomTest:) name:@"StartCustomTest" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EndCustomTest:) name:@"EndCustomTest" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarNoDiasTest:) name:@"ActualizarNoDiasTest" object:nil];
    
    [lblTitulo setText:NombreTitulo];
    
    [btnStarDate setTitle:[OSP_DateManager CambiaFecha:objScheduleCustomBE.startDate AlFormato:@"MMM, dd yyyy"] forState:0];
    if (objScheduleCustomBE.endDate) {
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:objScheduleCustomBE.endDate AlFormato:@"MMM, dd yyyy"] forState:0];
    }
    
    btnNoDays.tag = [objScheduleCustomBE.noMeasures intValue];
    [btnNoDays setTitle:[NSString stringWithFormat:@"%d Days",btnNoDays.tag] forState:0];
    
    if (btnNoDays.tag != 0) {
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
    }else {
        btnConfigurar.enabled = NO;
        btnConfigurar.alpha = 0.7;
    }
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
    
    [super dealloc];
    
    [objScheduleCustomBE release];
    [NombreTitulo release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
