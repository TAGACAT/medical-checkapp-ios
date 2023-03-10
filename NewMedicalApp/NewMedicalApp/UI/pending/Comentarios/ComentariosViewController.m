//
//  ComentariosViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComentariosViewController.h"

@interface ComentariosViewController ()

@end

@implementation ComentariosViewController

@synthesize arrayTable;
@synthesize aRequest;
@synthesize set;
@synthesize levelCode;
@synthesize diccionarioValores;



#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 
    CommentBE *comment = [arrayTable objectAtIndex:indexPath.row];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveComment" object:comment];
        [diccionarioValores setValue:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"Comment_%d",indexPath.row]];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddComment" object:comment];
        [diccionarioValores setValue:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"Comment_%d",indexPath.row]];
    }
    
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
        [cell.imageView setImage:[UIImage imageNamed:@"Comments.png"]];
    }
    CommentBE *comment = [arrayTable objectAtIndex:indexPath.row];
    cell.textLabel.text = comment.comment;
    
    
    if ([diccionarioValores objectForKey:[NSString stringWithFormat:@"Comment_%d",indexPath.row]]) {
        if ([[diccionarioValores objectForKey:[NSString stringWithFormat:@"Comment_%d",indexPath.row]] boolValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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
    
    self.title = @"Comments";
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Sending request...";
    NSURL *url = [NSURL URLWithString:@"http://www.onlinestudioproductions.com/medicineapp/Comment/ObtenerComments.php"];
    self.aRequest = [ASIFormDataRequest requestWithURL:url];
    [self.aRequest setPostValue:@"ENG" forKey:@"idioma"];
    [self.aRequest setPostValue:set forKey:@"set"];
    [self.aRequest setPostValue:levelCode forKey:@"levelCode"];
    [self.aRequest setDelegate:self];
    [self.aRequest startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *responseString = [request responseString];
    
    NSDictionary *responseDictionary = [responseString JSONValue];
    NSLog(@"%@",[responseString JSONValue]);
    NSMutableArray *setsArray = [responseDictionary objectForKey:@"comments"];
    
    NSMutableArray *arrayAux = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < [setsArray count]; i++) {
        
        NSDictionary *commentDictionary = [setsArray objectAtIndex:i];
        
        CommentBE *comment = [[CommentBE alloc] init];
        comment.comment = [commentDictionary objectForKey:@"comment"];
        comment.subCategoria = levelCode;
        comment.categoria = set;
        
        [arrayAux addObject:comment];
        [comment release];
    }
    
    
    [self setArrayTable:arrayAux];
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
    [levelCode release];
    [set release];
    [aRequest release];
    [arrayTable release];
    [super dealloc];
}
@end
