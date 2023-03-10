//
//  DrugTimeTakeDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrugTimeTakeDALC.h"

@implementation DrugTimeTakeDALC

+ (DrugScheduleTimeTake *)Agregar:(ScheduleTimeTakeBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    DrugScheduleTimeTake  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"DrugScheduleTimeTake" inManagedObjectContext:[appDelegate managedObjectContext]];
    
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

+ (NSMutableArray *)DameTomasOrdenadas:(Drug *)aMedicina{
    
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    
    for (DrugScheduleTimeTake *obj in aMedicina.drugScheduleTime.drugScheduleTimeTake)         
        [array addObject:obj];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return array;
    
}

@end
