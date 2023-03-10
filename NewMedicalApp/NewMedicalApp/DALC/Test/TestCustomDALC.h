//
//  TestCustomDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"

@interface TestCustomDALC : NSObject

+ (TestScheduleCustom *)Agregar:(TestScheduleCustomBE *)dicObj;
+ (BOOL)Eliminar:(TestScheduleCustom *)aCustom;


@end
