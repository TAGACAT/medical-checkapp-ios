//
//  TestTimeMeasureDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"

@interface TestTimeMeasureDALC : NSObject

+ (TestScheduleTimeMeasure *)Agregar:(TestScheduleTimeMeasureBE *)ObjBE;
+ (NSMutableArray *)DameTomasOrdenadas:(Test *)aTest;

@end
