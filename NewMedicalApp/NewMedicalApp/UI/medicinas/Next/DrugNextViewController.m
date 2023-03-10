//
//  DrugNextViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugNextViewController.h"

@interface DrugNextViewController ()

@end

@implementation DrugNextViewController
@synthesize ArrayTable;
@synthesize aMedicina;
@synthesize ArrayNotificaciones;


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


-(IBAction) segmentedControlIndexChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
            
        case 0:
            
            [self LlenarArrayTableHastaFinDeMes:NO];
            break;
            
        case 1:
            
            [self LlenarArrayTableHastaFinDeMes:YES];
            break;        
    }
}


- (void)LlenarArrayTableHastaFinDeMes:(BOOL)aFinDeMes{
    
    if ([ArrayNotificaciones count] == 0) {
        [self MostrarMensajeHUD:@"No takes" conEstado:0];
        return;
    }
    
    NSMutableArray *ArrayFinal = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *arrayAux = [[NSMutableArray alloc] init];
        
    [arrayAux addObject:[ArrayNotificaciones objectAtIndex:0]];
    
    for (int i = 1; i < [ArrayNotificaciones count]; i++) {
        
        Notificaciones *notiActual = [ArrayNotificaciones objectAtIndex:i];
        Notificaciones *notiAnterior = [ArrayNotificaciones objectAtIndex:i - 1];
        
        if ([OSP_DateManager DameDiferenciaDeDiasDe:notiAnterior.fechaHora conFechaFinal:notiActual.fechaHora] == 0) {
            
            [arrayAux addObject:[ArrayNotificaciones objectAtIndex:i]];
            
            if (i + 1 == [ArrayNotificaciones count]) {
                [ArrayFinal addObject:arrayAux];
            }
            
        }else {
            
            [ArrayFinal addObject:arrayAux];
            [arrayAux release];
            arrayAux = [[NSMutableArray alloc] init];
            [arrayAux addObject:[ArrayNotificaciones objectAtIndex:i]];
            
            if (i + 1 == [ArrayNotificaciones count]) {
                [ArrayFinal addObject:arrayAux];
            }
            
            
        }
        
        if (!aFinDeMes)
            if ([[[OSP_DateManager CambiaFecha:notiActual.fechaHora AlFormato:@"EEE"] uppercaseString] isEqualToString:@"SUN"] )
                break;     
        
    }
    
    [self setArrayTable:ArrayFinal];
    [myTable reloadData];
    if ([ArrayTable count] == 0) {
        [self MostrarMensajeHUD:@"No takes" conEstado:0];
    }
    [arrayAux release];
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
    Notificaciones *nextDrug = [[ArrayTable objectAtIndex:indexPath.row] objectAtIndex:0];    
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.imageView setImage:[UIImage imageNamed:@"Next.png"]];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.editing = TRUE;
    }
    
    cell.textLabel.text = [OSP_DateManager CambiaFecha:nextDrug.fechaHora AlFormato:@"MMM, dd yyyy"];
    
    NSString *Cadena = [NSString stringWithFormat:@"%@",[OSP_DateManager CambiaFechaA24Horas:nextDrug.fechaHora ConFormato:@""]];
    
    for (int i = 1 ; i < [[ArrayTable objectAtIndex:indexPath.row] count]; i++) {
        Notificaciones *DrugAux = [[ArrayTable objectAtIndex:indexPath.row] objectAtIndex:i];
        Cadena = [NSString stringWithFormat:@"%@, %@",Cadena, [OSP_DateManager CambiaFechaA24Horas:DrugAux.fechaHora ConFormato:@""]];
    }
    
    cell.detailTextLabel.text = Cadena;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DrugNextDetailViewController *nextDetailViewController = [[[DrugNextDetailViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [nextDetailViewController setArrayDetalle:[ArrayTable objectAtIndex:indexPath.row]];
    Notificaciones *noti = [[ArrayTable objectAtIndex:indexPath.row] objectAtIndex:0];
    [nextDetailViewController setTitle:[OSP_DateManager CambiaFecha:noti.fechaHora AlFormato:@"MMM, dd yyyy"]];
    [self.navigationController pushViewController:nextDetailViewController animated:YES];
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
    
    NSLog(@"%@",aMedicina.drugName);
    [mySegmented setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    [self setTitle:@"Next"];
    [self setArrayNotificaciones:[NotificacionesDALC ListarNotificacionesPorMedicina:aMedicina]];
    [self LlenarArrayTableHastaFinDeMes:NO];
    [myTable reloadData];
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
    
    [ArrayNotificaciones release];
    [aMedicina release];
    [ArrayTable release];
    [super dealloc];
}

@end
