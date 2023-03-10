//
//  ScheduleCustomTakeController.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "ScheduleCustomTakeController.h"


@implementation ScheduleCustomTakeController
@synthesize arrayTomas;
@synthesize NombreTitulo;


-(void)ComrpruebaSiHayTomas{
    
    [tlbTomas reloadData];
    
    if ([arrayTomas count] == 0) {
        viewSinTomas.hidden = NO;
        viewConTomas.hidden = YES;
    }else {
        viewSinTomas.hidden = YES;
        viewConTomas.hidden = NO;
    }
}


-(IBAction)Agregar:(id)Sender{
    
    ScheduleCustomTakeBE *objBE = [[[ScheduleCustomTakeBE alloc] init] autorelease];
    [objBE setDose:[NSNumber numberWithFloat:1.00]];
    [objBE setTime:@"08:00"];
    [objBE setTakeNumber:[NSNumber numberWithInt:0]];

    [arrayTomas addObject:objBE];
  
    [tlbTomas reloadData];
    [self ComrpruebaSiHayTomas];
}


#pragma mark - TableView Deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    
    return [arrayTomas count];
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
    
    ScheduleCustomTakeBE *objBE = ((ScheduleCustomTakeBE *)[arrayTomas objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",objBE.time];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f Units",[objBE.dose floatValue]];
	
    [cell.imageView setImage:[UIImage imageNamed:@"Dose.png"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ScheduleConfigurarCustomTakeController *viewCont = [[ScheduleConfigurarCustomTakeController alloc] initWithNibName:nil bundle:nil];
    [viewCont setNombreTitulo:NombreTitulo];
    [viewCont setObjTimeTakeBE:[arrayTomas objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewCont animated:YES];
    [viewCont release];    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
            [arrayTomas removeObjectAtIndex:indexPath.row];
            [self ComrpruebaSiHayTomas];
        
	}   
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



-(void)viewWillAppear:(BOOL)animated{
    
    [self ComrpruebaSiHayTomas];
    
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *btnPlus = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Agregar:)] autorelease];
    
    self.navigationItem.rightBarButtonItem = btnPlus;
    
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
    
    [NombreTitulo release];
    [arrayTomas release];
    [super dealloc];
}

@end
