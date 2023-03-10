//
//  TestCustomMeasureDALC.m
//  NewMedicalApp
//
//
//

#import "TestCustomMeasureDALC.h"

@implementation TestCustomMeasureDALC

+ (TestScheduleCustomMeasure *)Agregar:(TestScheduleCustomMeasure *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleCustomMeasure  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleCustomMeasure" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setMeasureNumber:ObjBE.measureNumber];
    [ObjDALC setTime:ObjBE.time];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


@end
