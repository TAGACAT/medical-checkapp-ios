//
//  IntakeViewController.m
//  NewMedicalApp
//
//
//

#import "IntakeViewController.h"

@interface IntakeViewController ()

@end

@implementation IntakeViewController
@synthesize objNoti;
@synthesize modo;
@synthesize arrayComentarios;

-(void)comentariosMeds:(NSNotification *)notification{
    
    [self setArrayComentarios:[notification object]];
}


-(IBAction)clicComments:(id)sender{
    
    CategoriasViewController *controller = [[[CategoriasViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller setNombreNotificacion:@"comentariosMeds"];
    [self.navigationController pushViewController:controller animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *unacceptedInput =
    [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
    
    if ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
        return NO;
    else 
        return YES;
    
}



-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}

-(void)cerrarVista{
    
    if (modo == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissModalViewControllerAnimated:YES];
    }
}

-(IBAction)clicSkype:(id)sender{
        
    [self cerrarVista];
}


-(IBAction)clicSave:(id)sender{
    
    if ([objNoti.drug.pillsLeft floatValue] - [txtDosis.text floatValue] <= 0) {
        [self mostrarMensaje:[NSString stringWithFormat:@"impossible archive on history. You need %.2f units left",[txtDosis.text floatValue]] andTittle:@"error"];
        [self cerrarVista];
        return;
    }
    
    [objNoti.drug setPillsLeft:[NSNumber numberWithFloat:[objNoti.drug.pillsLeft floatValue] - [txtDosis.text floatValue]]];
    
    if ([objNoti.drug.pillsLeft floatValue] <= [objNoti.drug.triggerUnitsLeft floatValue] && [objNoti.drug.refillAlarm intValue] == 1) {
        [NotificacionesDALC CrearNuevaNotificacionPara:objNoti.drug EnFecha:nil ConTexto:nil];
    }
    
    [DrugDALC Actualizar:objNoti.drug];
    [objNoti setEstado:[NSNumber numberWithInt:0]];
    [objNoti setDosis:[NSNumber numberWithFloat:[txtDosis.text floatValue]]];
    
    for (int i = 0; i < [arrayComentarios count]; i++) {
        [objNoti addComentariosObject:[ComentariosDALC Agregar:[arrayComentarios objectAtIndex:i]]];
    }
    
    [NotificacionesDALC ActualizarNotificacion:objNoti];
    [self cerrarVista];
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

    
    self.title = objNoti.drug.drugName;
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    
    [txtDosis setText:[NSString stringWithFormat:@"%.2f",[objNoti.dosis floatValue]]];
    [btnTime setTitle:[OSP_DateManager CambiaFechaA24Horas:objNoti.fechaHora ConFormato:@"MMM, dd yyyy  "] forState:0];
    
    NSArray *arrayNoti = [NotificacionesDALC ListarTodasNotificacionesPorMedicina:objNoti.drug];
    NSDate *next = nil;
    BOOL encontro = NO;
    
    for (Notificaciones *objBE in arrayNoti){
        
        if (encontro) {
            next = objBE.fechaHora;
            break;
        }
        if ([objBE.fechaHora isEqual:objNoti.fechaHora]) {
            encontro = YES;
        }
    }
    
    if (next != nil) {
        [btnNext setTitle:[OSP_DateManager CambiaFechaA24Horas:next ConFormato:@"MMM, dd yyyy  "] forState:0];
    }else{
        [btnNext setTitle:@"-" forState:0];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comentariosMeds:) name:@"comentariosMeds" object:nil];
        
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [arrayComentarios release];
    [objNoti release];
    [super dealloc];
}

@end
