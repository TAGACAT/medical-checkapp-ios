//
//  DrugDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugDALC.h"

@implementation DrugDALC

+ (Drug *)ObtenerMedicinaPorPK:(NSNumber *)PK{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * moc = [appDelegate managedObjectContext];    
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Drug" inManagedObjectContext:moc];
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];	
    [request setFetchLimit:1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"drugPK == %@",PK];
    [request setPredicate:predicate];
    NSArray *arrayMed = [moc executeFetchRequest:request error:nil];
    if ([arrayMed count] == 0) {
        return nil;
    }
    
    return [arrayMed objectAtIndex:0];
}

+ (BOOL)Eliminar:(Drug *)aMedicina{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[appDelegate managedObjectContext] deleteObject:aMedicina];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO BORRAR LA MEDICINA: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (NSArray *)Listar{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Drug" inManagedObjectContext:[appDelegate managedObjectContext]];
	[fetchRequest setEntity:entity];
	return [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

+ (Drug *)Actualizar:(Drug *)ObjDALC{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO ACTUALIZAR LA MEDICINA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}

+ (Drug *)Actualizar:(Drug *)ObjDALC conDatosDe:(MedicinaBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [ObjDALC setActivIngred:ObjBE.activIngred];
    [ObjDALC setAppINo:ObjBE.appINo];
    [ObjDALC setDosage:ObjBE.dosage];
    [ObjDALC setDrugName:ObjBE.drugName];
    [ObjDALC setDrugScheduleType:ObjBE.drugScheduleType];
    [ObjDALC setDrugPK:ObjBE.drugPK];
    [ObjDALC setForm:ObjBE.form];
    [ObjDALC setPackageSize:ObjBE.packageSize];
    [ObjDALC setPillsLeft:ObjBE.pillsLeft];
    [ObjDALC setRefillAlarm:ObjBE.refillAlarm];
    [ObjDALC setTriggerUnitsLeft:ObjBE.triggerUnitsLeft];
    
    [DrugTimeDALC Eliminar:ObjDALC.drugScheduleTime];
    [DrugIntervalDALC Eliminar:ObjDALC.drugScheduleInterval];
    [DrugCustomDALC Eliminar:ObjDALC.drugScheduleCustom];
   
    
    if (ObjBE.objScheduleCustom) 
        [ObjDALC setDrugScheduleCustom:[DrugCustomDALC Agregar:ObjBE.objScheduleCustom]];
    
    if (ObjBE.objScheduleInter)
        [ObjDALC setDrugScheduleInterval:[DrugIntervalDALC Agregar:ObjBE.objScheduleInter]];
    
    if (ObjBE.objScheduleTime)
        [ObjDALC setDrugScheduleTime:[DrugTimeDALC Agregar:ObjBE.objScheduleTime]];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO ACTUALIZAR LA MEDICINA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;



}

+ (Drug *)Agregar:(MedicinaBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Drug  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"Drug" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setActivIngred:ObjBE.activIngred];
    [ObjDALC setAppINo:ObjBE.appINo];
    [ObjDALC setDosage:ObjBE.dosage];
    [ObjDALC setDrugName:ObjBE.drugName];
    [ObjDALC setDrugScheduleType:ObjBE.drugScheduleType];
    [ObjDALC setDrugPK:ObjBE.drugPK];
    [ObjDALC setForm:ObjBE.form];
    [ObjDALC setPackageSize:ObjBE.packageSize];
    [ObjDALC setPillsLeft:ObjBE.pillsLeft];
    [ObjDALC setRefillAlarm:ObjBE.refillAlarm];
    [ObjDALC setTriggerUnitsLeft:ObjBE.triggerUnitsLeft];
    
    if (ObjBE.objScheduleCustom) 
        [ObjDALC setDrugScheduleCustom:[DrugCustomDALC Agregar:ObjBE.objScheduleCustom]];
    
    if (ObjBE.objScheduleInter)
        [ObjDALC setDrugScheduleInterval:[DrugIntervalDALC Agregar:ObjBE.objScheduleInter]];
    
    if (ObjBE.objScheduleTime)
        [ObjDALC setDrugScheduleTime:[DrugTimeDALC Agregar:ObjBE.objScheduleTime]];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA MEDICINA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}

@end
