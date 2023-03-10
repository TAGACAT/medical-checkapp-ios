//
//  DrugCustomDayDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugCustomDayDALC.h"

@implementation DrugCustomDayDALC


+ (DrugScheduleCustomDay *)Agregar:(ScheduleCustomDayBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleCustomDay  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleCustomDay" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setDayNumber:dicObj.dayNumber];
    [ObjDALC setNoDay:dicObj.noDay];
    
    for (int i = 0; i < [dicObj.ArrayScheduleCustomTakes count]; i++) {
        [ObjDALC addDrugScheduleCustomTakeObject:[DrugCustomTakeDALC Agregar:[dicObj.ArrayScheduleCustomTakes objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}


@end
