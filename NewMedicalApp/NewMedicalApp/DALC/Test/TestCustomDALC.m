//
//  TestCustomDALC.m
//  NewMedicalApp
//
//

#import "TestCustomDALC.h"

@implementation TestCustomDALC

+ (TestScheduleCustom *)Agregar:(TestScheduleCustomBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleCustom  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleCustom" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setEndDate:dicObj.endDate];
    [ObjDALC setNoMeasures:dicObj.noMeasures];
    [ObjDALC setStartDate:dicObj.startDate];
    
    for (int i = 0; i < [dicObj.testScheduleCustomDays count]; i++) {
        [ObjDALC addTestScheduleCustomDayObject:[TestCustomDayDALC Agregar:[dicObj.testScheduleCustomDays objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (BOOL)Eliminar:(TestScheduleCustom *)aCustom{
    
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


@end
