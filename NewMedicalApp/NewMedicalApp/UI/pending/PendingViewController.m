//
//  PendingViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PendingViewController.h"

@interface PendingViewController ()

@end

@implementation PendingViewController

@synthesize arrayMeds;
@synthesize arrayTable;
@synthesize arrayTest;


-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}

-(void)EliminarElemento:(Notificaciones *)obj{
        
    for (int i = 0; i < [arrayTemporal count]; i++) {
        
        Notificaciones *objTem = [arrayTemporal objectAtIndex:i];
        if ([OSP_DateManager DameDiferenciaDeHorasDe:objTem.fechaHora conFechaFinal:objTem.fechaHora] == 0) {
            [arrayTemporal removeObjectAtIndex:i];
            return;
        }
    }
}


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


-(void)ActualizarData{
    
    [arrayTest removeAllObjects];
    [arrayTable removeAllObjects];
    [arrayMeds removeAllObjects];
    
    [self setArrayMeds:[NotificacionesDALC ListarPentiendesMeds]];
    [self setArrayTest:[NotificacionesDALC ListarPentiendesTest]];
    
    [mySegmentedControl setTitle:[NSString stringWithFormat:@"Test (%d)",[arrayTest count]] forSegmentAtIndex:0];
    [mySegmentedControl setTitle:[NSString stringWithFormat:@"Meds (%d)",[arrayMeds count]] forSegmentAtIndex:1];
    
    if (mySegmentedControl.selectedSegmentIndex == 0) {
         [self setArrayTable:arrayTest];
    }else {
         [self setArrayTable:arrayMeds];
    }
    
    int total = [arrayMeds count] + [arrayTest count];
    if (total != 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",total];
    }else {
        self.tabBarItem.badgeValue = nil;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = total;
    
    if ([arrayTable count] == 0) {
//        mySegmentedControl.enabled = YES;
//        myToolBar.hidden = YES;
//        Editando = !Editando;
        [self MostrarMensajeHUD:@"No pendings" conEstado:0];
    }
    [myTableView reloadData];
}


-(IBAction)seleccionSegmented:(id)sender{
    
    [self ActualizarData];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%d",indexPath.row]];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"cell_%d",indexPath.row]] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell.imageView setImage:[UIImage imageNamed:@"Pending.png"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    Notificaciones *objBE = [arrayTable objectAtIndex:indexPath.row];
    
    if (mySegmentedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = [OSP_DateManager CambiaFechaA24Horas:objBE.fechaHora ConFormato:@"MMM, dd yyyy  "];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",objBE.test.testName];
    }
    else {
        
        cell.textLabel.text = [OSP_DateManager CambiaFechaA24Horas:objBE.fechaHora ConFormato:@"MMM, dd yyyy  "];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %.2f Units",objBE.drug.drugName,[objBE.dosis floatValue]];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!Editando) {
        if (mySegmentedControl.selectedSegmentIndex == 1) {
            IntakeViewController *controllerIntake = [[[IntakeViewController alloc] init] autorelease];
            [controllerIntake setModo:1];
            [controllerIntake setObjNoti:[arrayTable objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:controllerIntake animated:YES];
        }else{
            MeasureViewController *controllerMeasure = [[[MeasureViewController alloc] init] autorelease];
            [controllerMeasure setModo:1];
            [controllerMeasure setObjNoti:[arrayTable objectAtIndex:indexPath.row]];
            [self.navigationController pushViewController:controllerMeasure animated:YES];
        }
        return;
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        //[self EliminarElemento:[arrayTable objectAtIndex:indexPath.row]];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //[arrayTemporal addObject:[arrayTable objectAtIndex:indexPath.row]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActualizarData) name:@"ActualizarDataPending" object:nil];
    
    Editando = NO;
    arrayTemporal = [[NSMutableArray alloc] init];
    
    myToolBar.hidden = TRUE;
    
    UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonSystemItemEdit target:self action:@selector(onClickEditButton:)] autorelease];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud hide:YES];
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    [mySegmentedControl setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    [myToolBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];

//    [self performSelector:@selector(ActualizarData) withObject:nil afterDelay:0.2];
}

- (void)onClickEditButton:(id)sender {
    
    if ([arrayTable count] == 0) {
        return;
    }
    
    Editando = !Editando;
    
    UIBarButtonItem *rightButton;
    if (Editando) {
        rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonSystemItemDone target:self action:@selector(onClickEditButton:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        [rightButton release];
        myToolBar.hidden = NO;
        mySegmentedControl.enabled = NO;
    }
    else {
        rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonSystemItemEdit target:self action:@selector(onClickEditButton:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        [rightButton release];
        for (int i = 0; i < [arrayTable count]; i++) {
            UITableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        myToolBar.hidden = YES;
        mySegmentedControl.enabled = YES;
        [arrayTemporal removeAllObjects];
        
    }
    
}


- (IBAction)onClickDoneActionButton:(id)sender {
    
    for (int i = 0; i < [arrayTable count]; i++) {
        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
            Notificaciones *objNoti = [arrayTable objectAtIndex:i];
            if (mySegmentedControl.selectedSegmentIndex == 0) {
                
                [objNoti setEstado:[NSNumber numberWithInt:0]];
                [NotificacionesDALC ActualizarNotificacion:objNoti];
                
            }else{
                
                if ([objNoti.drug.pillsLeft intValue] == 0) {
                    [self mostrarMensaje:@"impossible archive on history. You have 0 pills left" andTittle:@"error"];
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
                
                [objNoti setEstado:[NSNumber numberWithInt:0]];
                [objNoti.drug setPillsLeft:[NSNumber numberWithFloat:[objNoti.drug.pillsLeft floatValue] - [objNoti.dosis floatValue]]];
                
                if ([objNoti.drug.pillsLeft floatValue] <= [objNoti.drug.triggerUnitsLeft floatValue] && [objNoti.drug.refillAlarm intValue] == 1) {
                    [NotificacionesDALC CrearNuevaNotificacionPara:objNoti.drug EnFecha:nil ConTexto:nil];
                }
                
                [DrugDALC Actualizar:objNoti.drug];
                [NotificacionesDALC ActualizarNotificacion:objNoti];
            }
        }
    }
    
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonSystemItemDone target:self action:@selector(onClickEditButton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    [arrayTemporal removeAllObjects];
    Editando = NO;
    mySegmentedControl.enabled = YES;
    myToolBar.hidden = YES;
    
    [self ActualizarData];
    for (int i = 0; i < [arrayTable count]; i++) {
        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

}

- (IBAction)onClickSkipActionButton:(id)sender {
    
    for (int i = 0; i < [arrayTable count]; i++) {
        UITableViewCell *cell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonSystemItemDone target:self action:@selector(onClickEditButton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    Editando = NO;
    mySegmentedControl.enabled = YES;
    myToolBar.hidden = YES;
    
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


-(void)viewWillAppear:(BOOL)animated{
    
    [self ActualizarData];
    [super viewWillAppear:animated];
}

-(void)dealloc{
    
    [arrayTemporal release];
    [arrayTest release];
    [arrayMeds release];
    [arrayTable release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
