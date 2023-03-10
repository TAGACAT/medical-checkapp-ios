//
//  NuevaMedicinaViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NuevaMedicinaViewController.h"

@interface NuevaMedicinaViewController ()

@end

@implementation NuevaMedicinaViewController
@synthesize NombreMedicina;


-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{    
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)GuardarMedicina:(id)Sender{
    
    if (txtNombre.text.length == 0) {
        [self mostrarMensaje:@"Incorrect name" andTittle:@"Medical Check App!"];
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    MedicinaBE *objMedicinaBE = [[[MedicinaBE alloc] init] autorelease];
    
    [objMedicinaBE setActivIngred:@"none"];
    [objMedicinaBE setDrugPK:[NSNumber numberWithInt:-1*(1 + [[prefs objectForKey:@"DrugsPK"] intValue])]];
    [objMedicinaBE setAppINo:[NSNumber numberWithInt:-1]];
    [objMedicinaBE setDosage:@"none"];
    [objMedicinaBE setDrugName:txtNombre.text];
    [objMedicinaBE setForm:txtForm.text];
    [objMedicinaBE setDrugScheduleType:[NSNumber numberWithInt:4]];
    
    PackageSizeViewController *myView = [[[PackageSizeViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    [myView CrearNuevaMedicina:objMedicinaBE];
    [myView setNombreTitulo:objMedicinaBE.drugName];
    [self.navigationController pushViewController:myView animated:YES];

    
    NSMutableArray *arrayController = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [arrayController removeObjectAtIndex:[arrayController count]-2];
    [self.navigationController setViewControllers:arrayController];
    [arrayController release];
    
    [prefs setObject:[NSNumber numberWithInt:1 + [[prefs objectForKey:@"DrugsPK"] intValue]] forKey:@"DrugsPK"];
    
}


#pragma mark -
#pragma mark pickerView Delegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    return [arrayPicker count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [((NSString *)[arrayPicker objectAtIndex:row]) lowercaseString];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [txtForm setText:[[arrayPicker objectAtIndex:row] lowercaseString]];
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
    
    arrayPicker = [[NSMutableArray alloc] initWithObjects:@"INHALATION", @"INJECTION/INTRAVENOUS", @"NASAL", @"EYE/OPHTHALMIC",
                   @"ORAL", @"SUBLINGUAL/BUCCAL", @"RECTAL", @"TOPICAL/TRANSDERMAL", nil];
    
    txtNombre.text = NombreMedicina;
    [txtForm setText:[[arrayPicker objectAtIndex:0] lowercaseString]]; 
    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(GuardarMedicina:)];
    self.navigationItem.rightBarButtonItem = btnSave;
    [btnSave release];
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
    
    [arrayPicker release];
    [NombreMedicina release];
    [super dealloc];
}
@end
