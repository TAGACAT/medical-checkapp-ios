//
//  SubCategoriaViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubCategoriaViewController.h"

@interface SubCategoriaViewController ()

@end

@implementation SubCategoriaViewController

@synthesize arrayTable;
@synthesize aRequest;
@synthesize set;
@synthesize diccionarioValores;



#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![diccionarioValores objectForKey:[NSString stringWithFormat:@"SubCategoria_%d",indexPath.row]]) {
        [diccionarioValores setValue:[NSMutableDictionary dictionaryWithObjectsAndKeys:nil] forKey:[NSString stringWithFormat:@"SubCategoria_%d",indexPath.row]];
    }
    
    
    ComentariosViewController *viewController = [[[ComentariosViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    NSDictionary *level = [arrayTable objectAtIndex:indexPath.row];
    [viewController setSet:set];
    [viewController setDiccionarioValores:[diccionarioValores objectForKey:[NSString stringWithFormat:@"SubCategoria_%d",indexPath.row]]];
    [viewController setLevelCode:[level objectForKey:@"leveCode"]];
    [self.navigationController pushViewController:viewController animated:YES];

    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%@",arrayTable);
    return [arrayTable count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSDictionary *level = [arrayTable objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",[level objectForKey:@"leveCode"],[level objectForKey:@"levelName"]];
    return cell;
    
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
    
    
    self.title = @"Subcategory";
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Sending request...";
    NSURL *url = [NSURL URLWithString:@"http://www.onlinestudioproductions.com/medicineapp/Comment/ObtenerLevels.php"];
    self.aRequest = [ASIFormDataRequest requestWithURL:url];
    [self.aRequest setPostValue:@"ENG" forKey:@"idioma"];
    [self.aRequest setPostValue:set forKey:@"set"];
    [self.aRequest setDelegate:self];
    [self.aRequest startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *responseString = [request responseString];
    
    NSDictionary *responseDictionary = [responseString JSONValue];
    NSLog(@"%@",[responseString JSONValue]);
    NSMutableArray *setsArray = [responseDictionary objectForKey:@"levels"];
    [self setArrayTable:setsArray];
    [myTable reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"%@",[error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please, try it later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
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
    
    [self.aRequest clearDelegatesAndCancel];
    [diccionarioValores release];
    [set release];
    [aRequest release];
    [arrayTable release];
    [super dealloc];
}


@end
