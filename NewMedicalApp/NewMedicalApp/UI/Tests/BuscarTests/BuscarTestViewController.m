//
//  BuscarTestViewController.m
//  NewMedicalApp
//
//
//

#import "BuscarTestViewController.h"

@interface BuscarTestViewController ()

@end

@implementation BuscarTestViewController

@synthesize arequest;
@synthesize ArrayTest;



#pragma mark - TableView Deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ArrayTest count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellIdentifier_%d",indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:16];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    

        
    NSDictionary *aDic = [ArrayTest objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"test"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Unit1:%@  -  Unit2:%@",[aDic objectForKey:@"unit1"],[aDic objectForKey:@"unit2"]];
        
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    cell.textLabel.numberOfLines = 2;
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.arequest clearDelegatesAndCancel];
    
    NSDictionary *dic = [ArrayTest objectAtIndex:indexPath.row];
    
    [objTestBE setAddedByUser:[NSNumber numberWithBool:YES]];
    [objTestBE setTestID:[NSNumber numberWithInt:[[dic objectForKey:@"id"] intValue]]];
    [objTestBE setDefault1:[NSNumber numberWithInt:[[dic objectForKey:@"default1"] floatValue]]];
    [objTestBE setDefault2:[NSNumber numberWithInt:[[dic objectForKey:@"default2"] floatValue]]];
    [objTestBE setLine11:[NSNumber numberWithInt:[[dic objectForKey:@"line11"] floatValue]]];
    [objTestBE setLine12:[NSNumber numberWithInt:[[dic objectForKey:@"line12"] floatValue]]];
    [objTestBE setLine13:[NSNumber numberWithInt:[[dic objectForKey:@"line13"] floatValue]]];
    [objTestBE setLine21:[NSNumber numberWithInt:[[dic objectForKey:@"line21"] floatValue]]];
    [objTestBE setLine22:[NSNumber numberWithInt:[[dic objectForKey:@"line22"] floatValue]]];
    [objTestBE setLine23:[NSNumber numberWithInt:[[dic objectForKey:@"line23"] floatValue]]];
    [objTestBE setRange1:[dic objectForKey:@"range1"]];
    [objTestBE setRange2:[dic objectForKey:@"range2"]];
    [objTestBE setStep1:[NSNumber numberWithInt:[[dic objectForKey:@"step1"] floatValue]]];
    [objTestBE setStep2:[NSNumber numberWithInt:[[dic objectForKey:@"step2"] floatValue]]];
    [objTestBE setTestName:[dic objectForKey:@"test"]];
    [objTestBE setUnit1:[dic objectForKey:@"unit1"]];
    [objTestBE setUnit2:[dic objectForKey:@"unit2"]];
    [objTestBE setTestScheduleType:[NSNumber numberWithInt:4]];
    
    if ([TestDALC ObtenerTestPorTestID:objTestBE.testID]) {
        
        UIActionSheet *myaction = [[[UIActionSheet alloc] initWithTitle:@"This regime will replace your current regime!" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil] autorelease];
        [myaction showFromTabBar:self.tabBarController.tabBar];
        [myaction setTag:1];
    }else{
        
        UIActionSheet *myaction = [[[UIActionSheet alloc] initWithTitle:@"Do you save this test?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil] autorelease];
        [myaction showFromTabBar:self.tabBarController.tabBar];
        [myaction setTag:2];
    }
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        if (actionSheet.tag == 1) {
            [TestDALC Actualizar:[TestDALC ObtenerTestPorTestID:objTestBE.testID] conDatosDe:objTestBE];
            [NotificacionesDALC EliminarNotificacionesPorTest:[TestDALC ObtenerTestPorTestID:objTestBE.testID]];
            
            VistaTestViewController *Controller = [[[VistaTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
            [Controller setObjTest:[TestDALC ObtenerTestPorTestID:objTestBE.testID]];
            [self.navigationController pushViewController:Controller animated:YES];
        }
        else{
            
            VistaTestViewController *Controller = [[[VistaTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
            [Controller setObjTest:[TestDALC Agregar:objTestBE]];
            [self.navigationController pushViewController:Controller animated:YES];
        }
    }
}

#pragma mark - request


-(void)checkForUpdatesTest{
    
    [hud show:YES];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.onlinestudioproductions.com/medicineapp/Tests/ObtenerListaTests.php"]];
    
    [request setPostValue:[NSString stringWithFormat:@"ENG"] forKey:@"idioma"];
    [request setPostValue:[NSString stringWithFormat:@"M"] forKey:@"genero"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{

    
    NSString *responseString = [request responseString];
    
    [self setArrayTest:[[responseString JSONValue] objectForKey:@"Tests"]];
    NSLog(@"%@",ArrayTest);
    [myTableView reloadData];
    [hud hide:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"%@", [request description]);
    [hud hide:YES];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Add Regime";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    objTestBE = [[TestBE alloc] init];
      
    [self checkForUpdatesTest];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self.arequest clearDelegatesAndCancel];
    [super viewDidDisappear:animated];
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
    
    [objTestBE release];
    [ArrayTest release];
    [arequest release];
    [super dealloc];
}

@end
