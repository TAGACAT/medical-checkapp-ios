//
//  DrugDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderDrugDALC.h"
#import "HeaderDrugBE.h"


@interface DrugDALC : NSObject

+ (Drug *)Agregar:(MedicinaBE *)ObjBE;
+ (NSArray *)Listar;
+ (BOOL)Eliminar:(Drug *)aMedicina;
+ (Drug *)ObtenerMedicinaPorPK:(NSNumber *)PK;
+ (Drug *)Actualizar:(Drug *)ObjDALC conDatosDe:(MedicinaBE *)ObjBE;
+ (Drug *)Actualizar:(Drug *)ObjDALC;

@end
