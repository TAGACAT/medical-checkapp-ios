//
//  VistaMedicinaViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VistaMedicinaViewController.h"

@interface VistaMedicinaViewController ()

@end

@implementation VistaMedicinaViewController
@synthesize objDrug;
@synthesize objDrugBE;
@synthesize arrayTiposScheduleTime;

-(void)ClicBtnCancel:(id)Sender{
    
    if (modifico) {
        UIAlertView *Alert = [[[UIAlertView alloc] initWithTitle:@"Meds" message:@"Do you want to save the changes?" delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:@"Yes",@"No",nil] autorelease];
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
    
    [DrugDALC Actualizar:objDrug conDatosDe:objDrugBE];
    
    if ([objDrug.drugScheduleType intValue] >= 0 && [objDrug.drugScheduleType intValue] <= 3) {
        [NotificacionesDALC CalcularNotificacionesTimeTake:objDrug];
    }else if ([objDrug.drugScheduleType intValue] == 5){
        [NotificacionesDALC CalcularNotificacionesInterval:objDrug];
    }else if ([objDrug.drugScheduleType intValue] == 6){
        [NotificacionesDALC CalcularNotificacionesCustom:objDrug];
    }else{
        [NotificacionesDALC EliminarNotificacionesPorMedicina:objDrug];
    }
    
    [hud hide:YES];
    modifico = NO;
    
    if (!sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ActualizarDataPending" object:nil];
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
        
        ScheduleTimeTakeBE *objTimeTakeBE = [[ScheduleTimeTakeBE alloc] init];
        
        [objTimeTakeBE setDose:[NSNumber numberWithInt:1]];
        [objTimeTakeBE setTakeNumber:[NSNumber numberWithInt:i+1]];
        
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

-(void)ActualizarPackageSize:(NSNotification *)notification{
    
    [btnPackageSize setTitle:[NSString stringWithFormat:@"%d Units",[((NSNumber *)[notification object])intValue]] forState:0];
    [btnPildorasRestantes setTitle:[NSString stringWithFormat:@"%d Units",[((NSNumber *)[notification object])intValue]] forState:0];
    [objDrugBE setPackageSize:[notification object]];
    [objDrugBE setPillsLeft:[notification object]];
    modifico = YES;
    
}

-(void)ActualizarScheduleTimeMed:(NSNotification *)notification{
    
    modifico = YES;
    
    btnSeleccionScheduleTime.tag = [[[notification object] objectAtIndex:1] intValue];
    [btnSeleccionScheduleTime setTitle:[[notification object] objectAtIndex:0] forState:0];
    [objDrugBE setDrugScheduleType:[NSNumber numberWithInt:[[[notification object] objectAtIndex:1] intValue]]];
    
    
    if (btnSeleccionScheduleTime.tag >= 0 && btnSeleccionScheduleTime.tag <= 3){
        
        ScheduleTimeBE *objScheduleTime = [[[ScheduleTimeBE alloc] init] autorelease];
        [objScheduleTime setNoTake:[NSNumber numberWithInt:1]];
        [objScheduleTime setStartDate:[NSDate date]];
        [objScheduleTime setEndDate:nil];
        [objScheduleTime setArrayScheduleTimeTake:[self DameArrayTimeTake:[[[notification object] objectAtIndex:1] intValue] + 1]];
         
        [objDrugBE setObjScheduleTime:objScheduleTime];
        [objDrugBE setObjScheduleInter:nil];
        [objDrugBE setObjScheduleCustom:nil];
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
        
    }else if (btnSeleccionScheduleTime.tag == 5) {
        
        ScheduleIntervalBE *objScheduleInter = [[[ScheduleIntervalBE alloc] init] autorelease];
        [objScheduleInter setStartDate:[NSDate date]];
        [objScheduleInter setEndDate:nil];
        [objScheduleInter setDose:[NSNumber numberWithInt:1]];
        [objScheduleInter setInterval:[NSNumber numberWithInt:1]];
        [objScheduleInter setFirstIntake:[NSString stringWithFormat:@"07:00"]];
        [objScheduleInter setBedTime:[NSString stringWithFormat:@"22:00"]];
        [objScheduleInter setInteruption:[NSNumber numberWithInt:0]];
        
        [objDrugBE setObjScheduleInter:objScheduleInter];
        [objDrugBE setObjScheduleTime:nil];
        [objDrugBE setObjScheduleCustom:nil];
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
        
    }else if (btnSeleccionScheduleTime.tag == 6) {
        
        ScheduleCustomBE *objScheduleCustom = [[[ScheduleCustomBE alloc] init] autorelease];
        [objScheduleCustom setStartDate:[NSDate date]];
        [objScheduleCustom setEndDate:nil];
        [objScheduleCustom setNoDays:[NSNumber numberWithInt:0]];
        [objScheduleCustom setArrayScheduleCustomDays:[[[NSMutableArray alloc] init] autorelease]];
        
        [objDrugBE setObjScheduleCustom:objScheduleCustom];
        [objDrugBE setObjScheduleInter:nil];
        [objDrugBE setObjScheduleTime:nil];
        btnConfigurar.enabled = YES;
        btnConfigurar.alpha = 1;
    }else {
        [objDrugBE setObjScheduleCustom:nil];
        [objDrugBE setObjScheduleInter:nil];
        [objDrugBE setObjScheduleTime:nil];
        btnConfigurar.enabled = NO;
        btnConfigurar.alpha = 0.5;
    }

}



#pragma mark - clic events

-(IBAction)ClicSeleccionScheduleTime:(id)sender{
 
    PickerViewList *myPicker = [[PickerViewList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [myPicker setNombreNotificacion:@"ActualizarScheduleTimeMed"];
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
        
        ScheduleTimeViewController *myViewTime = [[ScheduleTimeViewController alloc] initWithNibName:nil bundle:nil];
        [myViewTime setTitle:[NSString stringWithFormat:@"Schedule - %d Time a day",Tag+1]];
        [myViewTime setObjScheduleTimeBE:objDrugBE.objScheduleTime];
        [myViewTime setNombreTitulo:objDrug.drugName];
        [self.navigationController pushViewController:myViewTime animated:YES];
        [myViewTime release];
    }else if (Tag == 5) {
        
        ScheduleIntervalMedicinasViewController *viewInter = [[ScheduleIntervalMedicinasViewController alloc] initWithNibName:nil bundle:nil];
        [viewInter setTitle:@"Schedule - Interval"];
        [viewInter setNombreTitulo:objDrug.drugName];
        [viewInter setObjIntervalBE:objDrugBE.objScheduleInter];
        [self.navigationController pushViewController:viewInter animated:YES];
        [viewInter release];
        
    }else if (Tag == 6){
        
        ScheduleCustomMedsViewController *viewCustom = [[ScheduleCustomMedsViewController alloc] initWithNibName:nil bundle:nil];
        [viewCustom setTitle:@"Schedule Custom"];
        [viewCustom setNombreTitulo:objDrug.drugName];
        [viewCustom setObjScheduleCustomBE:objDrugBE.objScheduleCustom];
        [self.navigationController pushViewController:viewCustom animated:YES];
        [viewCustom release];
    }

}


-(IBAction)ClicRefillAlarm:(id)sender{
    
    RefillAlarmViewController *controller = [[[RefillAlarmViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller setObjMedicinaBE:objDrugBE];
    [self.navigationController pushViewController:controller animated:YES];
}


-(IBAction)ClicPackageSize:(id)sender{

    PickerViewNumber *myPicker = [[PickerViewNumber alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [myPicker setNombreNotificacion:@"ActualizarPackageSize"];
    [myPicker setNumeroColumnas:2];
    [myPicker setValorMinimo:[objDrugBE.packageSize intValue]];
    [myPicker setSeleccion:[objDrugBE.packageSize intValue]];
    [myPicker CrearElementos];
    [self.view addSubview:myPicker];
    [myPicker MostrarPickerView];
    [myPicker release];
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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarScheduleTimeMed:) name:@"ActualizarScheduleTimeMed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarPackageSize:) name:@"ActualizarPackageSize" object:nil];
    
    [self setArrayTiposScheduleTime:[NSArray arrayWithObjects:@"1 Time a day",@"2 Time a day",@"3 Time a day",@"4 Time a day",@"When needed",@"Interval",@"Custom", nil]];
    
    
    [self setObjDrugBE:[TranslateClassDataModel TranslateMedicina:objDrug]];
    [lblNombreMedicina setText:self.objDrugBE.drugName];
    [btnSeleccionScheduleTime setTitle:[arrayTiposScheduleTime objectAtIndex:[objDrugBE.drugScheduleType intValue]] forState:0];
    btnSeleccionScheduleTime.tag = [objDrugBE.drugScheduleType intValue];
    [btnPackageSize setTitle:[NSString stringWithFormat:@"%@ Units",self.objDrugBE.packageSize] forState:0];
    [btnPildorasRestantes setTitle:[NSString stringWithFormat:@"%.2f Units",[self.objDrugBE.pillsLeft floatValue]] forState:0];    
    
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
        
    [objDrugBE setPillsLeft:objDrug.pillsLeft];
    [btnPildorasRestantes setTitle:[NSString stringWithFormat:@"%.2f Units",[self.objDrugBE.pillsLeft floatValue]] forState:0];
    [super viewWillAppear:animated];
    [swRefillAlarm setOn:[objDrugBE.refillAlarm boolValue]];
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
    [objDrugBE release];
    [objDrug release];
    [super dealloc];
}

@end
