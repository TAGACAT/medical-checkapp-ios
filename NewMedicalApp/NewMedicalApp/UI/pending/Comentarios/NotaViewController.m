//
//  NotaViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotaViewController.h"

@interface NotaViewController ()

@end

@implementation NotaViewController
@synthesize objComent;



-(void)guardarNota{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveComment" object:objComent];
    [objComent setComment:txtNota.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddComment" object:objComent];
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
    
    self.title = @"Notes";
    UIBarButtonItem *btnSave = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(guardarNota)] autorelease];
    self.navigationItem.rightBarButtonItem = btnSave;
    
    [txtNota setText:objComent.comment];
    
    [txtNota becomeFirstResponder];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

    [objComent release];
    [super dealloc];
}


@end
