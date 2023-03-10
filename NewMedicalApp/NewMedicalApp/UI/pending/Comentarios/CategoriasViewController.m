//
//  CategoriasViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoriasViewController.h"

@interface CategoriasViewController ()

@end

@implementation CategoriasViewController
@synthesize arrayTable;
@synthesize aRequest;
@synthesize nombreNotificacion;


#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ((indexPath.row +1) == [arrayTable count]) {
        
        NotaViewController *viewController = [[NotaViewController alloc] initWithNibName:nil bundle:nil];
        [viewController setObjComent:comentNota];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }
    else {
        
        if (![diccionarioValores objectForKey:[NSString stringWithFormat:@"Categoria_%d",indexPath.row]]) {
            [diccionarioValores setValue:[NSMutableDictionary dictionaryWithObjectsAndKeys:nil] forKey:[NSString stringWithFormat:@"Categoria_%d",indexPath.row]];
        }
        
        NSDictionary *set = [arrayTable objectAtIndex:indexPath.row];
        SubCategoriaViewController *viewController = [[[SubCategoriaViewController alloc] initWithNibName:nil bundle:nil] autorelease];
        [viewController setDiccionarioValores:[diccionarioValores objectForKey:[NSString stringWithFormat:@"Categoria_%d",indexPath.row]]];
        [viewController setSet:[set objectForKey:@"set"]];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayTable count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if ((indexPath.row +1) == [arrayTable count]) {
        cell.textLabel.text = [arrayTable objectAtIndex:indexPath.row];
    }
    else {
        NSDictionary *set = [arrayTable objectAtIndex:indexPath.row];
        cell.textLabel.text = [set objectForKey:@"set"];
    }
    
    return cell;
    
}


-(void)AddComment:(NSNotification *)notification{
    
    [arrayComentarios addObject:[notification object]];
    NSLog(@"array comentatios: %@",arrayComentarios);
    [[NSNotificationCenter defaultCenter] postNotificationName:nombreNotificacion object:arrayComentarios];
}


-(void)RemoveComment:(NSNotification *)notification{
    
    [arrayComentarios removeObject:[notification object]];
   [[NSNotificationCenter defaultCenter] postNotificationName:nombreNotificacion object:arrayComentarios];
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
    
    comentNota = [[CommentBE alloc] init];
    [comentNota setComment:@""];
    arrayComentarios = [[NSMutableArray alloc] init];
    
    
    diccionarioValores = [[NSMutableDictionary alloc] init];
    
    self.title = @"Category";
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Sending request...";
    NSURL *url = [NSURL URLWithString:@"http://www.onlinestudioproductions.com/medicineapp/Comment/ObtenerSets.php"];
    self.aRequest = [ASIFormDataRequest requestWithURL:url];
    [self.aRequest setPostValue:@"ENG" forKey:@"idioma"];
    [self.aRequest setDelegate:self];
    [self.aRequest startAsynchronous];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddComment:) name:@"AddComment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RemoveComment:) name:@"RemoveComment" object:nil];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *responseString = [request responseString];

    NSDictionary *responseDictionary = [responseString JSONValue];
    NSLog(@"%@",[responseString JSONValue]);
    NSMutableArray *setsArray = [responseDictionary objectForKey:@"sets"];
    [self setArrayTable:setsArray];
    [arrayTable addObject:@"Notes"];
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
    [nombreNotificacion release];
    [comentNota release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [arrayComentarios release];
    [aRequest release];
    [arrayTable release];
    [super dealloc];
}


@end
