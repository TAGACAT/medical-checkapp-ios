//
//  DrugCustomDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderDrugDALC.h"
#import "HeaderDrugBE.h"


@interface DrugCustomDALC : NSObject

+ (DrugScheduleCustom *)Agregar:(ScheduleCustomBE *)dicObj;
+ (BOOL)Eliminar:(DrugScheduleCustom *)aCustom;

@end
