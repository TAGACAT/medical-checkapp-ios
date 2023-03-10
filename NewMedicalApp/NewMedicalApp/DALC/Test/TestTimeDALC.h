//
//  TestTimeDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"

@interface TestTimeDALC : NSObject

+ (TestScheduleTime *)Agregar:(TestScheduleTimeBE *)dicObj;
+ (BOOL)Eliminar:(TestScheduleTime *)aTime;


@end
