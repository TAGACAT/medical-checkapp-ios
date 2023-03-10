//
//  DrugCustomTakeDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugCustomTakeDALC.h"

@implementation DrugCustomTakeDALC


+ (DrugScheduleCustomTake *)Agregar:(ScheduleCustomTakeBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleCustomTake  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleCustomTake" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setDose:ObjBE.dose];
    [ObjDALC setTakeNumber:ObjBE.takeNumber];
    [ObjDALC setTime:ObjBE.time];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}


@end
