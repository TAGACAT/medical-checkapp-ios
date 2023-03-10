//
//  DrugIntervalDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugIntervalDALC.h"

@implementation DrugIntervalDALC

+ (BOOL)Eliminar:(DrugScheduleInterval *)aInterval{
    
    if (!aInterval) {
        return NO;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[appDelegate managedObjectContext] deleteObject:aInterval];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO BORRAR EL SCHEDULE: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
}


+ (DrugScheduleInterval *)Agregar:(ScheduleIntervalBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleInterval  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleInterval" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setBedTime:ObjBE.bedTime];
    [ObjDALC setDose:ObjBE.dose];
    [ObjDALC setEndDate:ObjBE.endDate];
    [ObjDALC setFirstIntake:ObjBE.firstIntake];
    [ObjDALC setInteruption:ObjBE.interuption];
    [ObjDALC setInterval:ObjBE.interval];
    [ObjDALC setStartDate:ObjBE.startDate];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}



@end
