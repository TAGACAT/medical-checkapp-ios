//
//  DrugTimeTakeDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderDrugDALC.h"
#import "HeaderDrugBE.h"


@interface DrugTimeTakeDALC : NSObject

+ (DrugScheduleTimeTake *)Agregar:(ScheduleTimeTakeBE *)ObjBE;
+ (NSMutableArray *)DameTomasOrdenadas:(Drug *)aMedicina;

@end
