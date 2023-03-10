//
//  OSP_DateManager.h
//  Fechas
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

//dd    ==> Indica el Dia numerico
//MM    ==> Indica el Mes numerico
//MMM   ==> Indica el Mes en Texto abreviado
//MMMM  ==> Indica el Mes en Texto Completo
//yy    ==> Indica el Año abreviado
//yyyy  ==> Indica el Año Completo
//EEE   ==> Indica dia abrev.
//EEEE  ==> Indica dia Completo.

#define Formato12Horas @"MM-dd-yyyy hh:mm:ss a"
#define Formato24Horas @"MM-dd-yyyy HH:mm:ss"

@interface OSP_DateManager : NSObject


+ (NSDate *)Fecha;
+ (NSDate *)FechaConHora;
+ (NSString *)CambiaFecha:(NSDate *)aFecha AlFormato:(NSString *)aFormato;
+ (NSDate *)CambiaTextoAFecha:(NSString *)aFecha AlFormato:(NSString *)aFormato;

+ (NSString *)CambiaFechaA12Horas:(NSDate *)aFecha ConFormato:(NSString *)aFormato;
+ (NSString *)CambiaFechaA24Horas:(NSDate *)aFecha ConFormato:(NSString *)aFormato;

+ (NSString *)CambiaFecha:(NSDate *)aFecha AlFormato:(NSString *)aFormato;

+ (float)DameDiferenciaDeHorasDe:(NSDate *)aFechaInicial conFechaFinal:(NSDate *)aFechaFinal;

+ (int)DameDiferenciaDeDiasDe:(NSDate *)aFechaInicial conFechaFinal:(NSDate *)aFechaFinal;

+ (NSString *)DameDiaDeLaSemana:(BOOL)conAbrev;


+ (NSTimeInterval)DameCantidadDeSegundosEnHora:(NSString *)aHora en24horas:(BOOL)aFormato conSisHorario:(NSString *)aSisHor;
+ (NSDate *)CombinaHoras:(NSString *)aHora conFecha:(NSDate *)aDate en24horas:(BOOL)aFormato conSisHorario:(NSString *)aSisHor;

+ (int)DameNumeroDiaDeFecha:(NSDate *)aFecha;
+ (int)DameNumeroMesDeFecha:(NSDate *)aFecha;
+ (int)DameNumeroAnioDeFecha:(NSDate *)aFecha;

+ (NSDate *)DameUltimoDiaDelMes:(NSDate *)aFecha;
+ (NSDate *)DamePrimerDiaDelMes:(NSDate *)aFecha;


@end
