//
//  DrugCustomTakeDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderDrugDALC.h"
#import "HeaderDrugBE.h"


@interface DrugCustomTakeDALC : NSObject


+ (DrugScheduleCustomTake *)Agregar:(ScheduleCustomTakeBE *)ObjBE;

@end
