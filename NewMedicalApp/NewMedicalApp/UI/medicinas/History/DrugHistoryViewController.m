//
//  DrugHistoryViewController.m
//  NewMedicalApp
//
//
//

#import "DrugHistoryViewController.h"

@interface DrugHistoryViewController ()

@end

@implementation DrugHistoryViewController
@synthesize objMedicina;
@synthesize arrayHistory;
@synthesize ArrayTable;


-(void)MostrarMensajeHUD:(NSString *)mensaje conEstado:(int)estado{
    
    [hud show:YES];
    if (estado == 1)
        hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUDcheckmark.png"]] autorelease];
    else
        hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUDerrormark.png"]] autorelease];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = mensaje;
    [hud hide:YES afterDelay:2];
}


-(IBAction)SelecteIndex:(id)sender{
    
    if (mySegmentedControl.selectedSegmentIndex == 0) {
        [self setArrayTable:[self DameHistoryDeLaSemana]];
    
    }else {
        [self setArrayTable:arrayHistory];
    }
    
    if ([ArrayTable count] == 0) 
        [self MostrarMensajeHUD:@"no history" conEstado:0];

    [myTableView reloadData];
}



-(NSMutableArray *)DameHistoryDeLaSemana{
    
    NSMutableArray *arrayFinal = [[[NSMutableArray alloc] init] autorelease];
    
    NSDate *FechaDiaDomingo = [NSDate date];
    
    for (int i = 0; i < 7; i++) {
            
//        if ([[[OSP_DateManager CambiaFecha:FechaDiaDomingo AlFormato:@"EEE"] uppercaseString] isEqualToString:@"SAT"]) {
        if ([[[OSP_DateManager CambiaFecha:FechaDiaDomingo AlFormato:@"EEE"] uppercaseString] isEqualToString:@"SUN"]) {
            break;
        }
        
        FechaDiaDomingo = [FechaDiaDomingo dateByAddingTimeInterval:60*60*24];
    }
    
    int diaSemana = [OSP_DateManager DameNumeroDiaDeFecha:FechaDiaDomingo];
    int Mes = [OSP_DateManager DameNumeroMesDeFecha:FechaDiaDomingo];
    int Anio = [OSP_DateManager DameNumeroAnioDeFecha:FechaDiaDomingo];
    
    FechaDiaDomingo = [OSP_DateManager CambiaTextoAFecha:[NSString stringWithFormat:@"%d-%d-%d",diaSemana,Mes,Anio] AlFormato:@"dd-MM-yyyy"];
    
    diaSemana-=6;
    
    if (diaSemana < 1) 
        diaSemana = 0;
    
    NSDate *FechaInicioSemana = [OSP_DateManager CambiaTextoAFecha:[NSString stringWithFormat:@"%d-%d-%d",diaSemana,Mes,Anio] AlFormato:@"dd-MM-yyyy"];
    
    for (int i = 0; i < [arrayHistory count]; i++) {
        
        Notificaciones *noti = [arrayHistory objectAtIndex:i];
         
        if ([OSP_DateManager DameDiferenciaDeDiasDe:FechaInicioSemana conFechaFinal:noti.fechaHora] >= 0 && [OSP_DateManager DameDiferenciaDeDiasDe:FechaDiaDomingo conFechaFinal:noti.fechaHora] <= 0) {
            [arrayFinal addObject:noti];
        }
    }
    
    return arrayFinal;
}

#pragma mark - UITableView métodos

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ArrayTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier_%d",indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Notificaciones *nextDrug = [ArrayTable objectAtIndex:indexPath.row];
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.imageView setImage:[UIImage imageNamed:@"History.png"]];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.editing = TRUE;
    }
    
    cell.textLabel.text = [OSP_DateManager CambiaFechaA24Horas:nextDrug.fechaHora ConFormato:@"MMM, dd yyyy  "];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Dose: %.2f Units",[nextDrug.dosis floatValue]];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DrugHistoryViewDetailViewController *viewController = [[[DrugHistoryViewDetailViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [viewController setTitle:@"Details"];
    [viewController setObjNotificacion:[ArrayTable objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud hide:YES];
    
    [mySegmentedControl setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self setArrayHistory:[NotificacionesDALC ListarHistoryMedicina:objMedicina]];
    [self SelecteIndex:nil];
    
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
    
    [objMedicina release];
    [arrayHistory release];
    [ArrayTable release];
    [super dealloc];
}

@end
