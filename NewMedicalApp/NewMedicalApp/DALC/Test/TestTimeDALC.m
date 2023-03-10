//
//  TestTimeDALC.m
//  NewMedicalApp
//
//
//

#import "TestTimeDALC.h"

@implementation TestTimeDALC


+ (TestScheduleTime *)Agregar:(TestScheduleTimeBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleTime  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleTime" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    NSLog(@"%@",dicObj.endDate);
    [ObjDALC setEndDate:dicObj.endDate];
    [ObjDALC setNoMeasures:dicObj.noMeasures];
    [ObjDALC setStartDate:dicObj.startDate];
    
    for (int i = 0; i < [dicObj.testScheduleTimeMeasures count]; i++) {
        [ObjDALC addTestScheduleTimeMeasureObject:[TestTimeMeasureDALC Agregar:[dicObj.testScheduleTimeMeasures objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
    
}


+ (BOOL)Eliminar:(TestScheduleTime *)aTime{
    
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


@end
