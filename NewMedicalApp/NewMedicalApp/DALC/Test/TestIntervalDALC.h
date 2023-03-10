//
//  TestIntervalDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"


@interface TestIntervalDALC : NSObject

+ (TestScheduleInterval *)Agregar:(TestScheduleIntervalBE *)ObjBE;
+ (BOOL)Eliminar:(TestScheduleInterval *)aInterval;

@end
