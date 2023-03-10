//
//  TestTimeMeasureDALC.m
//  NewMedicalApp
//
//
//

#import "TestTimeMeasureDALC.h"

@implementation TestTimeMeasureDALC

+ (TestScheduleTimeMeasure *)Agregar:(TestScheduleTimeMeasureBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    TestScheduleTimeMeasure  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"TestScheduleTimeMeasure" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setMeasureNumber:ObjBE.measureNumber];
    [ObjDALC setTime:ObjBE.time];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA ALTERNATIVA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (NSMutableArray *)DameTomasOrdenadas:(Test *)aTest{
    
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    
    for (TestScheduleTimeMeasure *obj in aTest.testScheduleTimeTake.testScheduleTimeMeasure)
        [array addObject:obj];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return array;
}


@end
