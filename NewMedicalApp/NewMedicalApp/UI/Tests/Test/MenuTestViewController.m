//
//  MenuTestViewController.m
//  NewMedicalApp
//
//
//

#import "MenuTestViewController.h"

@interface MenuTestViewController ()

@end

@implementation MenuTestViewController

@synthesize aTest;


-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}


-(IBAction)ClicQuickIntake:(id)sender{
    
    Notificaciones *objNoti = [NotificacionesDALC InsertarNuevaNotificacionDeTest:aTest EnFecha:[NSDate date] ConDosis:aTest.default1];
    MeasureViewController *controller = [[[MeasureViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [controller setModo:1];
    [controller setObjNoti:objNoti];
    [self.navigationController pushViewController:controller animated:YES];
    
//    NSArray *arrayNoti = [[[NSArray alloc] initWithArray:[NotificacionesDALC ListarNotificacionesPorTest:aTest]] autorelease];
//    if ([arrayNoti count] > 0) {
//        //[self mostrarMensaje:@"You don't Measure scheduled" andTittle:@"error"];
//        //return;
//        Notificaciones *noti = [arrayNoti objectAtIndex:0];
//        [noti setEstado:[NSNumber numberWithInt:2]];
//        [NotificacionesDALC ActualizarNotificacion:noti];
//    }else{
//        
//        Notificaciones *objNoti = [NotificacionesDALC InsertarNuevaNotificacionDeTest:aTest EnFecha:[NSDate date] ConDosis:aTest.default1];
//        [objNoti setEstado:[NSNumber numberWithInt:2]];
//        [NotificacionesDALC ActualizarNotificacion:objNoti];
//    }
//        
//    [self mostrarMensaje:@"Correct Measure" andTittle:@"Medical app"];
    
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
        VistaTestViewController *myView = [[[VistaTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [myView setObjTest:self.aTest];
        [self.navigationController pushViewController:myView animated:YES];
    }
    else if (indexPath.row == 1) {
        TestNextViewController *drugNextViewController = [[[TestNextViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [drugNextViewController setATest:aTest];
        [self.navigationController pushViewController:drugNextViewController animated:YES];
    }
    else if (indexPath.row == 2) {
        TestHistoryViewController *viewController = [[[TestHistoryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [viewController setObjTest:aTest];
        [viewController setTitle:@"Previous"];
        [self.navigationController pushViewController:viewController animated:YES];
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
    
    
    [lblTitulo setText:aTest.testName];
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
    [aTest release];
    [super dealloc];
}


@end
