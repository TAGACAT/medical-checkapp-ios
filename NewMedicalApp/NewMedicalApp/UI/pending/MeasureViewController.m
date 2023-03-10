//
//  MeasureViewController.m
//  NewMedicalApp
//
//
//

#import "MeasureViewController.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController


@synthesize modo;
@synthesize objNoti;
@synthesize arrayComentarios;

-(void)comentariosTest:(NSNotification *)notification{
    
    [self setArrayComentarios:[notification object]];
}

-(IBAction)clicComments:(id)sender{
    
    CategoriasViewController *controller = [[[CategoriasViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller setNombreNotificacion:@"comentariosTest"];
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

-(IBAction)clicDose:(id)sender{
    
    [txtDose becomeFirstResponder];
}


-(IBAction)clicSkype:(id)sender{
    
    [self cerrarVista];
}


-(IBAction)clicSave:(id)sender{
    
    [objNoti setDosis:[NSNumber numberWithFloat:[txtDose.text floatValue]]];
    [objNoti setEstado:[NSNumber numberWithInt:0]];
    
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
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    
    self.title = objNoti.test.testName;
    
    //[btnDoses setTitle:[NSString stringWithFormat:@"%.2f Units",[objNoti.dosis floatValue]] forState:0];
    [btnTime setTitle:[OSP_DateManager CambiaFechaA24Horas:objNoti.fechaHora ConFormato:@"MMM, dd yyyy  "] forState:0];
    [txtDose setText:[NSString stringWithFormat:@"%.2f",[objNoti.dosis floatValue]]];
    
    NSArray *arrayNoti = [NotificacionesDALC ListarTodasNotificacionesPorTest:objNoti.test];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comentariosTest:) name:@"comentariosTest" object:nil];
    
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
    
    [arrayComentarios release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [objNoti release];
    [super dealloc];
}

@end
