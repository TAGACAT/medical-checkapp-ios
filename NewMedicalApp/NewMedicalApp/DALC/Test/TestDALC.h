//
//  TestDALC.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>

#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"

@interface TestDALC : NSObject

+ (Test *)Agregar:(TestBE *)ObjBE;
+ (NSMutableArray *)Listar;
+ (NSMutableArray *)ListarTestAgregados;
+ (BOOL)Eliminar:(Test *)aTest;
+ (Test *)ObtenerTestPorTestID:(NSNumber *)testID;
+ (Test *)Actualizar:(Test *)ObjDALC conDatosDe:(TestBE *)ObjBE;
+ (Test *)Actualizar:(Test *)ObjDALC;

@end
