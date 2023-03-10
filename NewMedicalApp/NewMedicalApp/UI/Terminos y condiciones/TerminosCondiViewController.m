//
//  TerminosCondiViewController.m
//  MedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TerminosCondiViewController.h"
#import "SeleccionMedRegViewController.h"

@interface TerminosCondiViewController ()

@end

@implementation TerminosCondiViewController

- (IBAction)ClicContinuar:(id)sender{
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setBool:YES forKey:@"isTermsAccept"];    
    [userD synchronize];
    
    SeleccionMedRegViewController *viewSelect = [[SeleccionMedRegViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewSelect animated:YES];
    [viewSelect release];
}


- (IBAction)onChangeState:(id)sender{
    
    if (mySwitch.on) {
        btnAceptar.enabled = YES;
        btnAceptar.alpha = 1;
    }else {
        btnAceptar.enabled = NO;
        btnAceptar.alpha = 0.5;
    }
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
    self.navigationController.navigationBar.hidden = YES;
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

@end
