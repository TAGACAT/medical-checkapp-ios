//
//  DrugHistoryViewDetailViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugHistoryViewDetailViewController.h"

@interface DrugHistoryViewDetailViewController ()

@end

@implementation DrugHistoryViewDetailViewController

@synthesize objNotificacion;
@synthesize arrayTable;


#pragma mark - UITableView métodos

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier_%d",indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Comment *obj = [arrayTable objectAtIndex:indexPath.row];
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.imageView setImage:[UIImage imageNamed:@"Comments.png"]];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = obj.comment;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


#pragma mark -

-(IBAction)clicComent:(id)sender{
    
    ListaComentariosViewController *controller = [[[ListaComentariosViewController alloc] init] autorelease];
    
    NSMutableArray *arrayAux = [[[NSMutableArray alloc] init] autorelease];
    for (Comment *objComment in objNotificacion.comentarios){
        [arrayAux addObject:objComment];
    }
    
    [controller setArrayTable:arrayAux];
    [self.navigationController pushViewController:controller animated:YES];
    
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
    
    [btnDate setTitle:[OSP_DateManager CambiaFechaA24Horas:objNotificacion.fechaHora ConFormato:@"MMM, dd yyyy  "] forState:0];
    [btnDose setTitle:[NSString stringWithFormat:@"%.2f Units",[objNotificacion.dosis floatValue]] forState:0];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSMutableArray *arrayAux = [[[NSMutableArray alloc] init] autorelease];
    for (Comment *objComment in objNotificacion.comentarios){
        [arrayAux addObject:objComment];
    }
    
    [self setArrayTable:arrayAux];
    [tblComentarios reloadData];
    if ([arrayTable count] == 0) {
        lblNoComments.hidden = NO;
    }else{
        lblNoComments.hidden = YES;
    }
    
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
    
    [arrayTable release];
    [super dealloc];
}

@end
