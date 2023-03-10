//
//  MisMedicinasViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MisMedicinasViewController.h"

@interface MisMedicinasViewController ()

@end



@implementation MisMedicinasViewController

@synthesize arrayMedicamentos;
@synthesize hacerPush;


-(void)CompruebasSiExistenMedicinas{
    
    [self setArrayMedicamentos:(NSMutableArray *)[DrugDALC Listar]];
    [myTable reloadData];
    
    
    if ([arrayMedicamentos count] == 0) {
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
    return [arrayMedicamentos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *CellIdentifier = @"CellIdentifier"; 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    Drug *medicina = [arrayMedicamentos objectAtIndex:indexPath.row];
    
	if (cell == nil) {		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.imageView setImage:[UIImage imageNamed:@"Dose.png"]];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.editing = TRUE;
    }
    
    cell.textLabel.text = medicina.drugName;
	return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuMedicinasViewController *myView = [[MenuMedicinasViewController alloc] initWithNibName:nil bundle:nil];
    [myView setMedicina:[arrayMedicamentos objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:myView animated:YES];
    [myView release];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	return 50;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {

        [NotificacionesDALC EliminarNotificacionesPorMedicina:[arrayMedicamentos objectAtIndex:indexPath.row]];
        [DrugDALC Eliminar:[arrayMedicamentos objectAtIndex:indexPath.row]];
        [self CompruebasSiExistenMedicinas];
//        if ([DrugDALC Eliminar:[arrayMedicamentos objectAtIndex:indexPath.row]]) {
//            [self CompruebasSiExistenMedicinas];
//        }
        
	}   
}





#pragma mark - 


-(IBAction)BuscarParaAgregar:(id)Sender{
    
    BuscarMedicinaViewController *myView = [[BuscarMedicinaViewController alloc] init];
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
    
    [self CompruebasSiExistenMedicinas];
    
    [super viewWillAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    
    [arrayMedicamentos release];
    [super dealloc];
}

@end
