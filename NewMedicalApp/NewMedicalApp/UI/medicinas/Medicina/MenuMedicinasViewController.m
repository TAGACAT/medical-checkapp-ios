//
//  MenuMedicinasViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuMedicinasViewController.h"

@interface MenuMedicinasViewController ()

@end

@implementation MenuMedicinasViewController

@synthesize Medicina;


-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}


-(IBAction)ClicQuickIntake:(id)sender{
    
//    if ([Medicina.pillsLeft intValue] == 0) {
//        [self mostrarMensaje:@"Impossible. You have 0 pills left" andTittle:@"error"];
//        return;
//    }

    
//    NSArray *arrayNoti = [[[NSArray alloc] initWithArray:[NotificacionesDALC ListarNotificacionesPorMedicina:Medicina]] autorelease];
//    
//    
//    
//    if ([arrayNoti count] > 0) {
//        
//        Notificaciones *noti = [arrayNoti objectAtIndex:0];
//        
////        if ([Medicina.pillsLeft floatValue] - [noti.dosis floatValue] <= 0) {
////            [self mostrarMensaje:[NSString stringWithFormat:@"Impossible. You need %.2f pills left",[noti.dosis floatValue]] andTittle:@"error"];
////            return;
////        }
//        
//        [noti setEstado:[NSNumber numberWithInt:2]];
//        [NotificacionesDALC ActualizarNotificacion:noti];
//        
////        float pildorasRestantes = [Medicina.pillsLeft floatValue] - [noti.dosis floatValue];
////        [Medicina setPillsLeft:[NSNumber numberWithFloat:pildorasRestantes]];
////        [DrugDALC Actualizar:Medicina];
//    }else {
//        
////        [Medicina setPillsLeft:[NSNumber numberWithFloat:[Medicina.pillsLeft intValue] - 1]];
////        [DrugDALC Actualizar:Medicina];
//        Notificaciones *objNoti = [NotificacionesDALC InsertarNuevaNotificacionDeMedicina:Medicina EnFecha:[NSDate date] ConDosis:[NSNumber numberWithFloat:1]];
//        [objNoti setEstado:[NSNumber numberWithInt:2]];
//        [NotificacionesDALC ActualizarNotificacion:objNoti];
//    }

    
    Notificaciones *objNoti = [NotificacionesDALC InsertarNuevaNotificacionDeMedicina:Medicina EnFecha:[NSDate date] ConDosis:[NSNumber numberWithFloat:1.0]];
    IntakeViewController *controller = [[[IntakeViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller setModo:1];
    [controller setObjNoti:objNoti];
    [self.navigationController pushViewController:controller animated:YES];
    
    
//    [self mostrarMensaje:@"Correct take" andTittle:@"Medical app"];
    
}

#pragma mark delegate and dataSources TableView
#pragma mark delegate and sources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrayTable count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; 
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.text = [arrayTable objectAtIndex:indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.editing = TRUE;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        VistaMedicinaViewController *myView = [[[VistaMedicinaViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [myView setObjDrug:self.Medicina];
        [self.navigationController pushViewController:myView animated:YES];
    } 
    else if (indexPath.row == 1) {
        DrugNextViewController *drugNextViewController = [[DrugNextViewController alloc] initWithNibName:nil bundle:nil];
        [drugNextViewController setAMedicina:Medicina];
        [self.navigationController pushViewController:drugNextViewController animated:YES];
        [drugNextViewController release];
        drugNextViewController = nil;
    }
    else if (indexPath.row == 2) {
        DrugHistoryViewController *viewController = [[[DrugHistoryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [viewController setObjMedicina:Medicina];
        [viewController setTitle:@"Previous"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


-(IBAction)ClicRefill:(id)sender{
    
    UIActionSheet *myaction = [[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Do you really want to refill back to %d?",[Medicina.packageSize intValue]] delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil] autorelease];
    [myaction showFromTabBar:self.tabBarController.tabBar];
    return;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [Medicina setPillsLeft:Medicina.packageSize];
        [DrugDALC Actualizar:Medicina];
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
    
    arrayTable = [[NSMutableArray alloc] init];
    [arrayTable addObject:@"Schedule"];
    [arrayTable addObject:@"Next"];
    [arrayTable addObject:@"Previous"];
    
    
    [lblTitulo setText:Medicina.drugName];
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
    [arrayTable release];
    [Medicina release];
    [super dealloc];
}


@end
