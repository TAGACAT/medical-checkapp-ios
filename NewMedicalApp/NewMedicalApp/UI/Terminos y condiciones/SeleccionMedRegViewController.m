//
//  SeleccionMedRegViewController.m
//  MedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SeleccionMedRegViewController.h"
#import "AppDelegate.h"

@interface SeleccionMedRegViewController ()

@end



@implementation SeleccionMedRegViewController


-(IBAction)clicMeds:(id)sender{
    
    AppDelegate *theAppdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [theAppdelegate CreaTabBarControllerConIndice:0 ConOtroIndice:1];
}


-(IBAction)clicTest:(id)sender{

    AppDelegate *theAppdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [theAppdelegate CreaTabBarControllerConIndice:1 ConOtroIndice:2];
}


-(IBAction)clicLater:(id)sender{
    
    AppDelegate *theAppdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [theAppdelegate CreaTabBarControllerConIndice:0 ConOtroIndice:0];
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

@end
