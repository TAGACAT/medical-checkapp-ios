//
//  PackageSizeViewController.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PackageSizeViewController.h"

@interface PackageSizeViewController ()

@end

@implementation PackageSizeViewController

@synthesize NombreTitulo;
@synthesize objMedicinaBE;



-(void)mostrarMensaje:(NSString *)mensaje andTittle:(NSString *)titulo{    
    
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
    
    [Alert show];
    [Alert release];
}

#pragma mark pickerView Delegate



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [arrayPicker count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    return [[arrayPicker objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return (NSString *)[[arrayPicker objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    cantidadSeleccion = [self SeleccionEnPicker];
    [objMedicinaBE setTriggerUnitsLeft:[NSNumber numberWithInt:cantidadSeleccion*0.1]];
    [btnCantidad setTitle:[NSString stringWithFormat:@"%d Units",cantidadSeleccion] forState:0];
    [objMedicinaBE setPackageSize:[NSNumber numberWithInt:cantidadSeleccion]];
    [objMedicinaBE setPillsLeft:[NSNumber numberWithInt:cantidadSeleccion]];
}


#pragma mark - auxiliares

-(void)GuardarMedicina:(id)Sender{
    
    
    Drug *nuevaMedicina = [DrugDALC Agregar:objMedicinaBE];
    
    if (nuevaMedicina != nil) {
        
        [objMedicinaBE setDrugPK:nuevaMedicina.drugPK];
        
        NSLog(@"este es el DrugPK %@",nuevaMedicina.drugPK);
        
        VistaMedicinaViewController *myView = [[VistaMedicinaViewController alloc] initWithNibName:nil bundle:nil];
        [myView setObjDrug:nuevaMedicina];
        [self.navigationController pushViewController:myView animated:YES];
        [myView release];
        
        NSMutableArray *arrayController = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [arrayController removeObjectAtIndex:[arrayController count]-2];
        [self.navigationController setViewControllers:arrayController];
        [arrayController release];
    }else {
        [self mostrarMensaje:@"can't be added because there is medicine" andTittle:@"Medical Check App!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}


-(void)CrearNuevaMedicina:(MedicinaBE *)aMedicina{
    
    [self setObjMedicinaBE:aMedicina];
    
    [objMedicinaBE setPackageSize:[NSNumber numberWithInt:0]];
    [objMedicinaBE setPillsLeft:[NSNumber numberWithInt:0]];
    [objMedicinaBE setRefillAlarm:[NSNumber numberWithInt:0]];
    [objMedicinaBE setTriggerUnitsLeft:[NSNumber numberWithInt:0]];
    
    [objMedicinaBE setObjScheduleTime:nil];
    [objMedicinaBE setObjScheduleInter:nil];
    [objMedicinaBE setObjScheduleCustom:nil];
    
}

-(int)SeleccionEnPicker{
    
    float row1 = 10*[[[arrayPicker objectAtIndex:0] objectAtIndex:[pkView selectedRowInComponent:0]] intValue];
    float row2 = [[[arrayPicker objectAtIndex:1] objectAtIndex:[pkView selectedRowInComponent:1]] intValue];
    
    return row1+row2;
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

- (void)viewDidLoad
{
    self.title = @"Package size";
    
    lblTitulo.text = NombreTitulo;
    [super viewDidLoad];
    
    arrayPicker = [[NSMutableArray alloc] init];
    [arrayPicker addObject:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
    [arrayPicker addObject:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil]];
    
    UIBarButtonItem *btnPlus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(GuardarMedicina:)];
    self.navigationItem.rightBarButtonItem = btnPlus;
    [btnPlus release];
    
    cantidadSeleccion = [objMedicinaBE.packageSize intValue];
    [btnCantidad setTitle:[NSString stringWithFormat:@"%d Units",cantidadSeleccion] forState:0];
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
    [arrayPicker release];
    [NombreTitulo release];
    [super dealloc];
}
@end
