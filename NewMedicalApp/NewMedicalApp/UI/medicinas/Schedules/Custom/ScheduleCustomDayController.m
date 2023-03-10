//
//  ScheduleCustomDayController.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "ScheduleCustomDayController.h"


@implementation ScheduleCustomDayController

@synthesize NombreTitulo;
@synthesize arrayDias;


#pragma mark - TableView Deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    
    return [arrayDias count];
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
    
    ScheduleCustomDayBE *objBE = ((ScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = [NSString stringWithFormat:@"Day %@",objBE.noDay];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d intakes",[objBE.ArrayScheduleCustomTakes count]];
	
    [cell.imageView setImage:[UIImage imageNamed:@"schedule.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    ScheduleCustomTakeController *ViewTake = [[ScheduleCustomTakeController alloc] initWithNibName:nil bundle:nil];
    ViewTake.title = [NSString stringWithFormat:@"Day %@",((ScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]).noDay];
    [ViewTake setArrayTomas:((ScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]).ArrayScheduleCustomTakes];
    [ViewTake setNombreTitulo:NombreTitulo];
    [self.navigationController pushViewController:ViewTake animated:YES];
    [ViewTake release];
    
}



#pragma mark -


-(void)viewWillAppear:(BOOL)animated{
    
    [tblDias reloadData];
    [super viewWillAppear:animated];
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
    [self.navigationItem setTitle:@"Days"];
    [super viewDidLoad];
    
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
    
    [arrayDias release];
    [NombreTitulo release];
    [super dealloc];
}

@end
