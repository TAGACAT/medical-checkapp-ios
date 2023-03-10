//
//  NotificacionesDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notificaciones.h"
#import "HeaderDrugBE.h"
#import "OSP_DateManager.h"
#import "HeaderDrugDALC.h"
#import "HeaderTestDALC.h"
#import "HeaderTestBE.h"
#import "ComentariosDALC.h"

#import "AppDelegate.h"


@interface NotificacionesDALC : NSObject

//************** MEDS *****************
+ (Notificaciones *)InsertarNuevaNotificacionDeMedicina:(Drug *)aMedicina EnFecha:(NSDate *)aFecha ConDosis:(NSNumber *)aDosis;
+ (BOOL)EliminarNotificacionesPorMedicina:(Drug *)aMedicina;

+ (void)CalcularNotificacionesTimeTake:(Drug *)aMedicina;
+ (void)CalcularNotificacionesInterval:(Drug *)aMedicina;
+ (void)CalcularNotificacionesCustom:(Drug *)aMedicina;


+ (NSMutableArray *)ListarPentiendesMeds;
+ (NSMutableArray *)ListarNotificacionesPorMedicina:(Drug *)aMedicina;
+ (NSMutableArray *)ListarTodasNotificacionesPorMedicina:(Drug *)aMedicina;
+ (NSMutableArray *)ListarHistoryMedicina:(Drug *)aMedicina;


//************* TESTS ****************

+ (Notificaciones *)InsertarNuevaNotificacionDeTest:(Test *)aTest EnFecha:(NSDate *)aFecha ConDosis:(NSNumber *)aMeasure;
+ (BOOL)EliminarNotificacionesPorTest:(Test *)aTest;

+ (void)CalcularNotificacionesTimeMeasureTest:(Test *)aTest;
+ (void)CalcularNotificacionesIntervalTest:(Test *)aTest;
+ (void)CalcularNotificacionesCustomTest:(Test *)aTest;

+ (NSMutableArray *)ListarPentiendesTest;
+ (NSMutableArray *)ListarNotificacionesPorTest:(Test *)aTest;
+ (NSMutableArray *)ListarTodasNotificacionesPorTest:(Test *)aTest;
+ (NSMutableArray *)ListarHistoryTest:(Test *)aTest;

//************************************


+ (void)CrearNuevaNotificacionPara:(Drug *)aDrug EnFecha:(NSDate *)aFecha ConTexto:(NSString *)aTexto;

+ (NSMutableArray *)ListarTodasLasNotificacionesPendientes;

+ (void)ActualizarNotificacion:(Notificaciones *)objNoti;
+ (void)CrearNuevaNotificacion;

+ (Notificaciones *)ObtenerNotificacionPorIdDrug:(Drug *)aDrug enFecha:(NSDate *)aFecha;
+ (Notificaciones *)ObtenerNotificacionPorIdTest:(Test *)aTest enFecha:(NSDate *)aFecha;


+ (NSMutableArray *)Listar;

+ (NSMutableArray *)ListarNotificacionesDeMismaFecha:(NSDate *)aFecha;

@end
