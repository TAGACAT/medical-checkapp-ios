//
//  TestCustomDayDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"

@interface TestCustomDayDALC : NSObject

+ (TestScheduleCustomDay *)Agregar:(TestScheduleCustomDayBE *)dicObj;

@end
