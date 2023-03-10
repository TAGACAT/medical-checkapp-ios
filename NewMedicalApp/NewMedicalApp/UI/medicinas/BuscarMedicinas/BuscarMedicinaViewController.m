//
//  BuscarMedicinaViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuscarMedicinaViewController.h"

@interface BuscarMedicinaViewController ()

@end

@implementation BuscarMedicinaViewController

@synthesize arequest;
@synthesize ArrayMedicamentos;


#pragma mark - scroll Delegate


-(void)CargarSiguientePagina{
    
    Pagina++;
    [self.arequest clearDelegatesAndCancel];
    [self BuscarMedicinasEnServicio];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if(scrollView.contentOffset.y<0){
        return;
    }
    else if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)+50 ) {
        
        
        if ([ArrayMedicamentos count] == 0 || Cargando || [[ArrayMedicamentos objectAtIndex:[ArrayMedicamentos count]-1] isEqual:@"add medicine"]) return;
        
        NSLog(@"Cargar mas data");
        [self CargarSiguientePagina];
    }
}



#pragma mark - SearchBarDelegate


-(BOOL )searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSCharacterSet *unacceptedInput =
    [[NSCharacterSet characterSetWithCharactersInString:CHARACTERS_NUMBERS] invertedSet];
    
    if ([[text componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
        return NO;
    else 
        return YES;
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self.arequest clearDelegatesAndCancel];
    
    if (searchBar.text.length == 0 && [ArrayMedicamentos count] > 0) {
        [ArrayMedicamentos removeAllObjects];
        [myTableView reloadData];
        [lblRestantes setText:@"Total: 0 meds"];
    }
    
    NSLog(@"Sige tipeando");
    
    
    if (searchBar.text.length > 0) {
        [ArrayMedicamentos removeAllObjects];
        Pagina = 0;
        [self BuscarMedicinasEnServicio];
    }else {
        [ArrayMedicamentos removeAllObjects];
        [myTableView reloadData];
        [lblRestantes setText:@"Total: 0 meds"];
        [hud hide:YES];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
	[searchBar resignFirstResponder];
}


#pragma mark - TableView Deleagte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [ArrayMedicamentos count];
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
    
    
    if (indexPath.row == [ArrayMedicamentos count]-1) {
        
        UILabel *lblLoadMore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        lblLoadMore.center = CGPointMake(cell.frame.size.width/2, cell.frame.size.height/2);
        [lblLoadMore setText:[ArrayMedicamentos objectAtIndex:indexPath.row]];
        [lblLoadMore setTextAlignment:UITextAlignmentCenter];
        [lblLoadMore setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        lblLoadMore.textColor = [UIColor grayColor];
        [cell addSubview:lblLoadMore];
        [lblLoadMore release];
        
        
    }else{
        
        NSDictionary *aDic = [ArrayMedicamentos objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@  -  %@",[aDic objectForKey:@"Drugname"],[aDic objectForKey:@"Dosage"], [aDic objectForKey:@"SponsorApplicant"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"Activeingred"]];
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        cell.textLabel.numberOfLines = 3;
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [mySearchBar resignFirstResponder];
    [self.arequest clearDelegatesAndCancel];
    
    if (indexPath.row == [ArrayMedicamentos count]-1) {
        
        if ([[ArrayMedicamentos objectAtIndex:indexPath.row] isEqual:@"add medicine"]) {
            NSLog(@"Agrega una nueva medicina");
            NuevaMedicinaViewController *ViewControllerNM = [[NuevaMedicinaViewController alloc] initWithNibName:nil bundle:nil];
            [ViewControllerNM setNombreMedicina:mySearchBar.text];
            [self.navigationController pushViewController:ViewControllerNM animated:YES];
            [ViewControllerNM release];
        }
        else{
            [self CargarSiguientePagina];
        }
        
        return;
    }
    
    
    
    [objMedicinaBE setActivIngred:[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"Activeingred"]];
    [objMedicinaBE setDrugPK:[NSNumber numberWithInt:[[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"DrugsPK"] intValue]]];
    [objMedicinaBE setAppINo:[NSNumber numberWithInt:[[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"AppINo"] intValue]]];
    [objMedicinaBE setDosage:[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"Dosage"]];
    [objMedicinaBE setDrugName:[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"Drugname"]];
    [objMedicinaBE setForm:[[ArrayMedicamentos objectAtIndex:indexPath.row] objectForKey:@"Form"]];
    [objMedicinaBE setDrugScheduleType:[NSNumber numberWithInt:4]];
    
    if ([DrugDALC ObtenerMedicinaPorPK:objMedicinaBE.drugPK]) {
        
        UIActionSheet *myaction = [[[UIActionSheet alloc] initWithTitle:@"By confirming, this new medication schedule will replace any previous schedule for this medication" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil] autorelease];
        [myaction showFromTabBar:self.tabBarController.tabBar];
        return;
    }
    
    PackageSizeViewController *myView = [[PackageSizeViewController alloc] initWithNibName:nil bundle:nil];
    [myView CrearNuevaMedicina:objMedicinaBE];
    [myView setNombreTitulo:objMedicinaBE.drugName];
    [self.navigationController pushViewController:myView animated:YES];
    [myView release];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        Drug *objDM = [DrugDALC ObtenerMedicinaPorPK:objMedicinaBE.drugPK];
        [DrugDALC Eliminar:objDM];

        PackageSizeViewController *myView = [[PackageSizeViewController alloc] initWithNibName:nil bundle:nil];
        [myView CrearNuevaMedicina:objMedicinaBE];
        [myView setNombreTitulo:objMedicinaBE.drugName];
        [self.navigationController pushViewController:myView animated:YES];
        [myView release];
        
    }
}

#pragma mark - request


-(void)BuscarMedicinasEnServicio{
    
    Cargando = YES;
    [hud show:YES];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.arequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.onlinestudioproductions.com/medicineapp/Drugs/BuscarMedicinaPorCriteriosNuevo.php"]];
    
    [self.arequest setPostValue:[NSString stringWithFormat:@"%@", mySearchBar.text] forKey:@"texto"];      
    [self.arequest setPostValue:[NSString stringWithFormat:@"%d", Pagina] forKey:@"pagina"];      
    [self.arequest setPostValue:[NSString stringWithFormat:@"%d", 50] forKey:@"registros"];
    
    [self.arequest setDelegate:self];
    [self.arequest startAsynchronous];
    
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    Cargando = NO;
    
    NSString *responseString = [request responseString];
    NSDictionary *dict = [responseString JSONValue];
    
    int restantes = [[dict objectForKey:@"Cantidad"] intValue];
    [lblRestantes setText:[NSString stringWithFormat:@"Total: %d",restantes]];
    
    
    if ([ArrayMedicamentos count] == 0) {
        [self setArrayMedicamentos:[dict objectForKey:@"Drugs"]];
    }else{
        [ArrayMedicamentos removeLastObject];
        [ArrayMedicamentos addObjectsFromArray:[dict objectForKey:@"Drugs"]];
    }
    
    if (restantes <= 0){ 
        [ArrayMedicamentos addObject:@"add medicine"];
    }
    else{
        [ArrayMedicamentos addObject:@"load more"];
    }
    
    
    NSLog(@"%@",dict);
    
    [myTableView reloadData];
    [hud hide:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    Cargando = NO;
    NSLog(@"este es el error %@", [request description]);
    [hud hide:YES];
    
    UIAlertView *alertaError = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No Network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] autorelease];
    [alertaError show];
    
//    if ([ArrayMedicamentos count] > 0) {
//        [ArrayMedicamentos removeAllObjects];
//    }
//    [self setArrayMedicamentos:[NSMutableArray arrayWithObject:@"add medicine"]];
//    [myTableView reloadData];
    
}


-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if ([ArrayMedicamentos count] > 0) {
        [ArrayMedicamentos removeAllObjects];
    }
    [self setArrayMedicamentos:[NSMutableArray arrayWithObject:@"add medicine"]];
    [myTableView reloadData];
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
    Pagina = 0;
    Cargando = NO;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud hide:YES];
    
    objMedicinaBE = [[MedicinaBE alloc] init];
    
    mySearchBar.tintColor = [UIColor colorWithRed:0.73 green:0 blue:0 alpha:1];
    [mySearchBar becomeFirstResponder];
    
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self.arequest clearDelegatesAndCancel];
    [super viewDidDisappear:animated];
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
    
    [objMedicinaBE release];
    [ArrayMedicamentos release];
    [arequest release];
    [super dealloc];
}

@end
