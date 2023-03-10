//
//  DrugCustomDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugCustomDALC.h"

@implementation DrugCustomDALC


+ (BOOL)Eliminar:(DrugScheduleCustom *)aCustom{
    
    if (!aCustom) {
        return NO;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[appDelegate managedObjectContext] deleteObject:aCustom];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO BORRAR EL SCHEDULE: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (DrugScheduleCustom *)Agregar:(ScheduleCustomBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleCustom  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleCustom" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setEndDate:dicObj.endDate];
    [ObjDALC setNoDays:dicObj.noDays];
    [ObjDALC setStartDate:dicObj.startDate];
    
    for (int i = 0; i < [dicObj.ArrayScheduleCustomDays count]; i++) {
        [ObjDALC addDrugScheduleCustomDayObject:[DrugCustomDayDALC Agregar:[dicObj.ArrayScheduleCustomDays objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}



@end
