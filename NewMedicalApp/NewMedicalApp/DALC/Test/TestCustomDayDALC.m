//
//  TestCustomDayDALC.m
//  NewMedicalApp
//
//
//

#import "TestCustomDayDALC.h"

@implementation TestCustomDayDALC

+ (TestScheduleCustomDay *)Agregar:(TestScheduleCustomDayBE *)dicObj{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleCustomDay  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleCustomDay" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setDayNumber:dicObj.dayNumber];
    [ObjDALC setNoDays:dicObj.noDays];
    
    for (int i = 0; i < [dicObj.testScheduleCustomMeasures count]; i++) {
        [ObjDALC addTestScheduleCustomMeasureObject:[TestCustomMeasureDALC Agregar:[dicObj.testScheduleCustomMeasures objectAtIndex:i]]];
    }
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


@end
