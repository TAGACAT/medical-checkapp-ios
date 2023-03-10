//
//  DrugTimeDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugTimeDALC.h"

@implementation DrugTimeDALC


+ (BOOL)Eliminar:(DrugScheduleTime *)aTime{
    
    if (!aTime) {
        return NO;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[appDelegate managedObjectContext] deleteObject:aTime];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO BORRAR EL SCHEDULE: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (DrugScheduleTime *)Agregar:(ScheduleTimeBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleTime  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleTime" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    NSLog(@"%@",dicObj.endDate);
    [ObjDALC setEndDate:dicObj.endDate];
    [ObjDALC setNoTakes:dicObj.noTake];
    [ObjDALC setStartDate:dicObj.startDate];
    
    for (int i = 0; i < [dicObj.arrayScheduleTimeTake count]; i++) {
        [ObjDALC addDrugScheduleTimeTakeObject:[DrugTimeTakeDALC Agregar:[dicObj.arrayScheduleTimeTake objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}



@end
