//
//  TestIntervalDALC.m
//  NewMedicalApp
//
//
//

#import "TestIntervalDALC.h"

@implementation TestIntervalDALC


+ (TestScheduleInterval *)Agregar:(TestScheduleIntervalBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleInterval  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleInterval" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setBedTime:ObjBE.bedTime];
    [ObjDALC setEndDate:ObjBE.endDate];
    [ObjDALC setFirstMeasure:ObjBE.firstMeasure];
    [ObjDALC setInteruption:ObjBE.interruption];
    [ObjDALC setInterval:ObjBE.interval];
    [ObjDALC setStartDate:ObjBE.startDate];
    [ObjDALC setMeasureNumber:ObjBE.measureNumber];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (BOOL)Eliminar:(TestScheduleInterval *)aInterval{
    
    
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


@end
