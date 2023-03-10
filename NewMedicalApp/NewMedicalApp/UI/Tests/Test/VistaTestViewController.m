//
//  VistaTestViewController.m
//  NewMedicalApp
//
//
//

#import "VistaTestViewController.h"

@interface VistaTestViewController ()

@end

@implementation VistaTestViewController

@synthesize objTest;
@synthesize objTestBE;
@synthesize arrayTiposScheduleTime;

-(void)ClicBtnCancel:(id)Sender{
    
    if (modifico) {
        UIAlertView *Alert = [[[UIAlertView alloc] initWithTitle:@"Test" message:@"Do you want to save the changes?" delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:@"Yes",@"No",nil] autorelease];
        Alert.tag = 1;
        [Alert show];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            
            [self ClicBtnSaveEdit:nil];
            
            
        }else if (buttonIndex == 2){
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)GuardarData:(id)sender{
    
    [TestDALC Actualizar:objTest conDatosDe:objTestBE];
    
    if ([objTest.testScheduleType intValue] >= 0 && [objTest.testScheduleType intValue] <= 3) {
        [NotificacionesDALC CalcularNotificacionesTimeMeasureTest:objTest];
    }else if ([objTest.testScheduleType intValue] == 5){
        [NotificacionesDALC CalcularNotificacionesIntervalTest:objTest];
    }else if ([objTest.testScheduleType intValue] == 6){
        [NotificacionesDALC CalcularNotificacionesCustomTest:objTest];
    }else{
        [NotificacionesDALC EliminarNotificacionesPorTest:objTest];
    }
    
    [hud hide:YES];
    modifico = NO;
    
    if (!sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ActualizarDataPendingTest" object:nil];
    [NotificacionesDALC CrearNuevaNotificacion];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)ClicBtnSaveEdit:(id)Sender{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Saving configuration...";
    [hud show:YES];
    
    [self performSelector:@selector(GuardarData:) withObject:Sender afterDelay:0.2];
}



-(NSMutableArray *)DameArrayTimeTake:(int)CantidadTomas{
    
    int horaInicio = 8;
    int RangoHoras = 0;
    if ((CantidadTomas - 1) != 0)
        RangoHoras = 12/(CantidadTomas - 1);
    
    NSMutableArray *arrayTimeTake = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0 ; i < CantidadTomas; i++) {
        
        TestScheduleTimeMeasureBE *objTimeTakeBE = [[TestScheduleTimeMeasureBE alloc] init];
        
        [objTimeTakeBE setMeasureNumber:[NSNumber numberWithFloat:0]];
        
        if (horaInicio < 10)
            [objTimeTakeBE setTime:[NSString stringWithFormat:@"0%d:00",horaInicio]];
        else
            [objTimeTakeBE setTime:[NSString stringWithFormat:@"%d:00",horaInicio]];
        
        horaInicio = horaInicio + RangoHoras;
        [arrayTimeTake addObject:objTimeTakeBE];
        [objTimeTakeBE release];
    }
    
    return arrayTimeTake;
}



#pragma mark - notificaciones



-(void)ActualizarScheduleTimeTest:(NSNotification *)notification{
    
    modifico = YES;
    
    btnSeleccionScheduleTime.tag = [[[notification object] objectAtIndex:1] intValue];
    [btnSeleccionScheduleTime setTitle:[[notification object] objectAtIndex:0] forState:0];
    [objTestBE setTestScheduleType:[NSNumber numberWithInt:[[[notification object] objectAtIndex:1] intValue]]];
    
    
    if (btnSeleccionScheduleTime.tag >= 0 && btnSeleccionScheduleTime.tag <= 3){
        
        TestScheduleTimeBE *objScheduleTime = [[[TestScheduleTimeBE alloc] init] autorelease];
        [objScheduleTime setNoMeasures:[NSNumber numberWithInt:1]];
        [objScheduleTime setStartDate:[NSDate date]];
        [objScheduleTime setEndDate:nil];
        [objScheduleTime setTestScheduleTimeMeasures:[self DameArrayTimeTake:[[[notification object] objectAtIndex:1] intValue] + 1]];
        
        [objTestBE setTestScheduleTimeBE:objScheduleTime];
        [objTestBE setTestScheduleIntervalBE:nil];
        [objTestBE setTestScheduleCustomBE:nil];
        
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
        
    }else if (btnSeleccionScheduleTime.tag == 5) {
        
        TestScheduleIntervalBE *objScheduleInter = [[[TestScheduleIntervalBE alloc] init] autorelease];
        [objScheduleInter setStartDate:[NSDate date]];
        [objScheduleInter setEndDate:nil];
        [objScheduleInter setMeasureNumber:[NSNumber numberWithInt:0]];
        [objScheduleInter setInterval:[NSNumber numberWithInt:1]];
        [objScheduleInter setFirstMeasure:[NSString stringWithFormat:@"07:00"]];
        [objScheduleInter setBedTime:[NSString stringWithFormat:@"22:00"]];
        [objScheduleInter setInterruption:[NSNumber numberWithInt:0]];
        
        [objTestBE setTestScheduleIntervalBE:objScheduleInter];
        [objTestBE setTestScheduleTimeBE:nil];
        [objTestBE setTestScheduleCustomBE:nil];
        
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
        
    }else if (btnSeleccionScheduleTime.tag == 6) {
        
        TestScheduleCustomBE *objScheduleCustom = [[[TestScheduleCustomBE alloc] init] autorelease];
        [objScheduleCustom setStartDate:[NSDate date]];
        [objScheduleCustom setEndDate:nil];
        [objScheduleCustom setNoMeasures:[NSNumber numberWithInt:0]];
        [objScheduleCustom setTestScheduleCustomDays:[[[NSMutableArray alloc] init] autorelease]];
        
        [objTestBE setTestScheduleCustomBE:objScheduleCustom];
        [objTestBE setTestScheduleIntervalBE:nil];
        [objTestBE setTestScheduleTimeBE:nil];
        
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
    }else {
        [objTestBE setTestScheduleCustomBE:nil];
        [objTestBE setTestScheduleIntervalBE:nil];
        [objTestBE setTestScheduleTimeBE:nil];
        
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 0.5;
    }
    
}



#pragma mark - clic events

-(IBAction)ClicSeleccionScheduleTime:(id)sender{
    
    PickerViewList *myPicker = [[PickerViewList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [myPicker setNombreNotificacion:@"ActualizarScheduleTimeTest"];
    [myPicker setSeleccion:((UIView *)sender).tag];
    [myPicker setArrayPicker:[NSArray arrayWithObject:arrayTiposScheduleTime]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
}


-(IBAction)ClicConFigurarScheduleTime:(id)sender{
    
    modifico = YES;
    
    int Tag = btnSeleccionScheduleTime.tag;
    
    if (Tag >= 0 && Tag <= 3) {
        
        ScheduleTimeTestViewController *myViewTime = [[ScheduleTimeTestViewController alloc] initWithNibName:nil bundle:nil];
        [myViewTime setTitle:[NSString stringWithFormat:@"Schedule - %d Time a day", Tag+1]];
        [myViewTime setObjScheduleTimeBE:objTestBE.testScheduleTimeBE];
        [myViewTime setNombreTitulo:objTest.testName];
        [self.navigationController pushViewController:myViewTime animated:YES];
        [myViewTime release];
    }else if (Tag == 5) {
        
        ScheduleIntervalTestViewController *viewInter = [[ScheduleIntervalTestViewController alloc] initWithNibName:nil bundle:nil];
        [viewInter setTitle:@"Schedule - Interval"];
        [viewInter setNombreTitulo:objTest.testName];
        [viewInter setObjIntervalBE:objTestBE.testScheduleIntervalBE];
        [self.navigationController pushViewController:viewInter animated:YES];
        [viewInter release];
        
    }else if (Tag == 6){
        
        CustomTestViewController *viewCustom = [[CustomTestViewController alloc] initWithNibName:nil bundle:nil];
        [viewCustom setTitle:@"Schedule - Custom"];
        [viewCustom setNombreTitulo:objTest.testName];
        [viewCustom setObjScheduleCustomBE:objTestBE.testScheduleCustomBE];
        [self.navigationController pushViewController:viewCustom animated:YES];
        [viewCustom release];
    }
    
}



#pragma mark -



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
    
    modifico = NO;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarScheduleTimeTest:) name:@"ActualizarScheduleTimeTest" object:nil];
    
    [self setArrayTiposScheduleTime:[NSArray arrayWithObjects:@"1 Time a day",@"2 Time a day",@"3 Time a day",@"4 Time a day",@"When needed",@"Interval",@"Custom", nil]];
    
    
    [self setObjTestBE:[TranslateClassDataModel TranslateTest:objTest]];
    [lblNombreMedicina setText:self.objTest.testName];
    [btnSeleccionScheduleTime setTitle:[arrayTiposScheduleTime objectAtIndex:[objTest.testScheduleType intValue]] forState:0];
    btnSeleccionScheduleTime.tag = [objTest.testScheduleType intValue];
    
    UIBarButtonItem *btnPlus = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(ClicBtnSaveEdit:)] autorelease];
    self.navigationItem.rightBarButtonItem = btnPlus;
    
    UIBarButtonItem *btnBack = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(ClicBtnCancel:)] autorelease];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    if (btnSeleccionScheduleTime.tag == 4) {
        btnConfigurar.enabled = NO;
        btnConfigurar.alpha = 0.5;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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
    [arrayTiposScheduleTime release];
    [objTest release];
    [objTestBE release];
    [super dealloc];
}

@end
