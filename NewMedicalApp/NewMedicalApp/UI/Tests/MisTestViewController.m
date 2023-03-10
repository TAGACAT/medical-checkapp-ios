//
//  MisTestViewController.m
//  NewMedicalApp
//
//
//

#import "MisTestViewController.h"

@interface MisTestViewController ()

@end

@implementation MisTestViewController

@synthesize arrayTest;
@synthesize hacerPush;


-(void)CompruebasSiExistenTests{
    
    [self setArrayTest:(NSMutableArray *)[TestDALC ListarTestAgregados]];
    [myTable reloadData];
    
    
    if ([arrayTest count] == 0) {
        viewConMedicinas.hidden = YES;
        viewSinMedicinas.hidden = NO;
    }else {
        viewConMedicinas.hidden = NO;
        viewSinMedicinas.hidden = YES;
    }
    
    
}

#pragma mark -
#pragma mark TableView Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTest count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    Test *objTest = [arrayTest objectAtIndex:indexPath.row];
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.imageView setImage:[UIImage imageNamed:@"Dose.png"]];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.editing = TRUE;
    }
    
    cell.textLabel.text = objTest.testName;
	return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MenuTestViewController *myView = [[[MenuTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [myView setATest:[arrayTest objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:myView animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	return 50;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [NotificacionesDALC EliminarNotificacionesPorTest:[arrayTest objectAtIndex:indexPath.row]];
        [TestDALC Eliminar:[arrayTest objectAtIndex:indexPath.row]];
        [self CompruebasSiExistenTests];
        
//        if ([TestDALC Eliminar:[arrayTest objectAtIndex:indexPath.row]]) {
//            [self CompruebasSiExistenTests];
//        }
//        Test *objTest = [arrayTest objectAtIndex:indexPath.row];
//        [objTest setAddedByUser:[NSNumber numberWithBool:NO]];
//        [TestDALC Actualizar:objTest];
	}
}





#pragma mark -


-(IBAction)BuscarParaAgregar:(id)Sender{
    
    BuscarTestViewController *myView = [[BuscarTestViewController alloc] init];
    [self.navigationController pushViewController:myView animated:YES];
    [myView release];
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
    
    UIBarButtonItem *btnPlus = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(BuscarParaAgregar:)] autorelease];
    
    self.navigationItem.rightBarButtonItem = btnPlus;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    
    if (hacerPush) {
        [self BuscarParaAgregar:nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self CompruebasSiExistenTests];
    
    [super viewWillAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    
    [arrayTest release];
    [super dealloc];
}



@end
