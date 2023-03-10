//
//  DrugTimeDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderDrugDALC.h"
#import "HeaderDrugBE.h"


@interface DrugTimeDALC : NSObject

+ (DrugScheduleTime *)Agregar:(ScheduleTimeBE *)dicObj;
+ (BOOL)Eliminar:(DrugScheduleTime *)aTime;


@end
