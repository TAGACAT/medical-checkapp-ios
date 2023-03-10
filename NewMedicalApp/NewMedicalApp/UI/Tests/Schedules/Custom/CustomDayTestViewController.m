//
//  CustomDayTestViewController.m
//  NewMedicalApp
//
//
//

#import "CustomDayTestViewController.h"

@interface CustomDayTestViewController ()

@end

@implementation CustomDayTestViewController
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
    
    TestScheduleCustomDayBE *objBE = ((TestScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = [NSString stringWithFormat:@"Day %@",objBE.noDays];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d measures",[objBE.testScheduleCustomMeasures count]];
	
    [cell.imageView setImage:[UIImage imageNamed:@"schedule.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    CustomMeasureTestViewController *ViewTake = [[CustomMeasureTestViewController alloc] initWithNibName:nil bundle:nil];
    ViewTake.title = [NSString stringWithFormat:@"Day %@",((TestScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]).noDays];
    [ViewTake setArrayTomas:((TestScheduleCustomDayBE *)[arrayDias objectAtIndex:indexPath.row]).testScheduleCustomMeasures];
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
