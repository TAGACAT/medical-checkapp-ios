
//
//  ScheduleTimeViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleTimeViewController.h"

@interface ScheduleTimeViewController ()

@end

@implementation ScheduleTimeViewController
@synthesize NombreTitulo;
@synthesize objScheduleTimeBE;


-(void)FechaBotonStartMeds:(NSNotification *)notification{
    
    [btnStartDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    [objScheduleTimeBE setStartDate:[notification object]];
}


-(void)FechaBotonEndMeds:(NSNotification *)notification{
    
    if ([notification object] == nil) {
        [btnEndDate setTitle:@"Never" forState:0];
    }else {
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:[notification object] AlFormato:@"MMM, dd yyyy"] forState:0];
    }
    
    [objScheduleTimeBE setEndDate:[notification object]];

}



#pragma mark - Clics Events


-(IBAction)ClicStartDate:(UIButton *)sender{
    
    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    kal.title = @"Start Date";
    [kal setModo:0];
    [kal setNombreNotificacion:@"FechaBotonStartMeds"];
    [kal showAndSelectDate:objScheduleTimeBE.startDate];
    
    [self.navigationController pushViewController:kal animated:YES];
}


-(IBAction)ClicEndDate:(UIButton *)sender{

    KalViewController *kal = [[[KalViewController alloc] init] autorelease];
    
    kal.title = @"End Date";
    [kal setModo:1];
    [kal setNombreNotificacion:@"FechaBotonEndMeds"];
//    if (objScheduleTimeBE.endDate != nil) {
//        [kal showAndSelectDate:objScheduleTimeBE.endDate];
//    }else {
//        [kal showAndSelectDate:[objScheduleTimeBE.startDate dateByAddingTimeInterval:60*60*24]];
//    }
//        
    [self.navigationController pushViewController:kal animated:YES];
}


#pragma mark - TableView Deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    
    return [objScheduleTimeBE.arrayScheduleTimeTake count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier"; 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		//cell.textLabel.font = [UIFont fontWithName:@"Helvetica_Bold" size:16];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }
    
    ScheduleTimeTakeBE *objBE = ((ScheduleTimeTakeBE *)[objScheduleTimeBE.arrayScheduleTimeTake objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = objBE.time;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f Units",[objBE.dose floatValue]];
	
    [cell.imageView setImage:[UIImage imageNamed:@"Dose.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ScheduleTimeTakeViewController *myViewController = [[ScheduleTimeTakeViewController alloc] initWithNibName:nil bundle:nil];
    [myViewController setObjTimeTakeBE:[objScheduleTimeBE.arrayScheduleTimeTake objectAtIndex:indexPath.row]];
    [myViewController setNombreTitulo:lblTitulo.text];
    [self.navigationController pushViewController:myViewController animated:YES];
    [myViewController release];
}



#pragma mark -




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
    
    [lblTitulo setText:NombreTitulo];
    
    [btnStartDate setTitle:[OSP_DateManager CambiaFecha:objScheduleTimeBE.startDate AlFormato:@"MMM, dd yyyy"] forState:0];
    if (objScheduleTimeBE.endDate) {
        [btnEndDate setTitle:[OSP_DateManager CambiaFecha:objScheduleTimeBE.endDate AlFormato:@"MMM, dd yyyy"] forState:0];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FechaBotonStartMeds:) name:@"FechaBotonStartMeds" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FechaBotonEndMeds:) name:@"FechaBotonEndMeds" object:nil];

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
    
    [_TableView reloadData];
    [super viewWillAppear:animated];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NombreTitulo release];
    [objScheduleTimeBE release];
    [super dealloc];
}

@end
