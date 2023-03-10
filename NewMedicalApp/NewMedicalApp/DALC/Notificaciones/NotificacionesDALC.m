//
//  NotificacionesDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificacionesDALC.h"

@implementation NotificacionesDALC


+ (NSDate *)DameFechaInicio:(NSDate *)StartDate{
        
    
    NSDate *finDeMes = [OSP_DateManager DameUltimoDiaDelMes:[NSDate date]];
    NSDate *InicioDeMes = [OSP_DateManager DamePrimerDiaDelMes:[NSDate date]];
    
    if ([OSP_DateManager DameDiferenciaDeDiasDe:StartDate conFechaFinal:finDeMes] < 0) 
        return nil;
    else if ([OSP_DateManager DameDiferenciaDeDiasDe:StartDate conFechaFinal:InicioDeMes] >=0 ) 
        return InicioDeMes;
    else if ([OSP_DateManager DameDiferenciaDeDiasDe:StartDate conFechaFinal:[NSDate date]] >= 0) 
        return StartDate;
    else if ([OSP_DateManager DameDiferenciaDeDiasDe:StartDate conFechaFinal:[NSDate date]] <= 0) 
        return StartDate;
    
    return nil;
}


+ (NSDate *)DameFechaFin:(NSDate *)EndDate{
    
    NSDate *finDeMes = [OSP_DateManager DameUltimoDiaDelMes:[NSDate date]];
    
    if (!EndDate) 
        return finDeMes;
    
    if ([OSP_DateManager DameDiferenciaDeDiasDe:EndDate conFechaFinal:finDeMes] >= 0) {
        return EndDate;
    }else {
        return finDeMes;
    }  
}


#pragma mark - pendientes

+ (NSMutableArray *)ListarPentiendesMeds{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identificador == %@  AND fechaHora <= %@ AND estado >= %@ ",[NSNumber numberWithInt:1],[NSDate date],[NSNumber numberWithInt:1]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identificador == %@  AND fechaHora <= %@ AND estado == %@ || (estado == %@ AND identificador == %@)",[NSNumber numberWithInt:1],[NSDate date],[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayPendientes = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayPendientes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayPendientes;
}


+ (NSMutableArray *)ListarPentiendesTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identificador == %@  AND fechaHora <= %@ AND estado == %@ || (estado == %@ AND identificador == %@)",[NSNumber numberWithInt:2],[NSDate date],[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayPendientes = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayPendientes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayPendientes;
}


#pragma mark - Insertar


+ (Notificaciones *)InsertarNuevaNotificacionDeTest:(Test *)aTest EnFecha:(NSDate *)aFecha ConDosis:(NSNumber *)aMeasure{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Notificaciones  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setTest:aTest];
    [ObjDALC setEstado:[NSNumber numberWithInt:1]];//1:pendiente 0: historial 2:pendiente de quickMeasure
    [ObjDALC setIdentificador:[NSNumber numberWithInt:2]];//1 : medicina 2: test
    [ObjDALC setFechaHora:aFecha];
    [ObjDALC setDosis:aMeasure];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA NOTIFICACION: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (Notificaciones *)InsertarNuevaNotificacionDeMedicina:(Drug *)aMedicina EnFecha:(NSDate *)aFecha ConDosis:(NSNumber *)aDosis{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Notificaciones  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setDrug:aMedicina];
    [ObjDALC setEstado:[NSNumber numberWithInt:1]];//1:pendiente 0: historial  2:pendiente de quickIntake
    [ObjDALC setIdentificador:[NSNumber numberWithInt:1]];//1 : medicina 2: test
    [ObjDALC setFechaHora:aFecha];
    [ObjDALC setDosis:aDosis];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR LA NOTIFICACION: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;
}

+ (BOOL)EliminarNotificacionesPorTest:(Test *)aTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (aTest.notificacion) {
        
        for (Notificaciones *managedObject in aTest.notificacion) {
            [[appDelegate managedObjectContext] deleteObject:managedObject];
        }
        
        NSError *error;
        
        if (![[appDelegate managedObjectContext] save:&error]){
            NSLog(@"NO SE PUDO BORRAR LAS NOTIFICACIONES: %@", [error localizedDescription]);
            return NO;
        }
    }
    return YES;
}


+ (BOOL)EliminarNotificacionesPorMedicina:(Drug *)aMedicina{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (aMedicina.notificacion) {
              
        for (Notificaciones *managedObject in aMedicina.notificacion) {
            [[appDelegate managedObjectContext] deleteObject:managedObject];
        }
        
        NSError *error;
        
        if (![[appDelegate managedObjectContext] save:&error]){
            NSLog(@"NO SE PUDO BORRAR LAS NOTIFICACIONES: %@", [error localizedDescription]);
            return NO;
        }
    }
    return YES;
}


+ (NSMutableArray *)ListarNotificacionesPorTest:(Test *)aTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"test == %@  AND fechaHora >= %@ AND estado == %@",aTest,[NSDate date],[NSNumber numberWithInt:1]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
}


+ (NSMutableArray *)ListarTodasNotificacionesPorTest:(Test *)aTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"test == %@ ",aTest];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
    
}
+ (NSMutableArray *)ListarHistoryTest:(Test *)aTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"test == %@ AND estado == %@",aTest,[NSNumber numberWithInt:0]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
    
}

+ (NSMutableArray *)ListarNotificacionesPorMedicina:(Drug *)aMedicina{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"drug == %@  AND fechaHora >= %@ AND estado == %@",aMedicina,[NSDate date],[NSNumber numberWithInt:1]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;

}


+ (NSMutableArray *)ListarTodasNotificacionesPorMedicina:(Drug *)aMedicina{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"drug == %@ ",aMedicina];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
    
}

+ (NSMutableArray *)ListarHistoryMedicina:(Drug *)aMedicina{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"drug == %@ AND estado == %@",aMedicina,[NSNumber numberWithInt:0]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
}



#pragma mark - TimeTake Meds Test

+ (void)CalcularNotificacionesTimeMeasureTest:(Test *)aTest{
 
    NSDate *FechaInicio = [self DameFechaInicio:aTest.testScheduleTimeTake.startDate];
    
    if (!FechaInicio)
        return;
    
    
    [self EliminarNotificacionesPorTest:aTest];
    
    NSDate *FechaFin = [self DameFechaFin:aTest.testScheduleTimeTake.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];
    
    NSMutableArray *ArrayHorarios = [TestTimeMeasureDALC DameTomasOrdenadas:aTest];
    
    for (int i = 0; i < DiferenciaDias; i++) {
        
        for (int j = 0 ; j < [ArrayHorarios count]; j ++) {
            
            TestScheduleTimeMeasure *objDALC = [ArrayHorarios objectAtIndex:j];
            NSDate *Fecha = [OSP_DateManager CombinaHoras:objDALC.time conFecha:FechaInicio en24horas:YES conSisHorario:nil];
            [NotificacionesDALC InsertarNuevaNotificacionDeTest:aTest EnFecha:[Fecha dateByAddingTimeInterval:i*60*60*24] ConDosis:aTest.default1];
            
        }
    }
}


+ (void)CalcularNotificacionesTimeTake:(Drug *)aMedicina{
    
    NSDate *FechaInicio = [self DameFechaInicio:aMedicina.drugScheduleTime.startDate];
    
    if (!FechaInicio) 
        return;
    
    
    [self EliminarNotificacionesPorMedicina:aMedicina];
    
    NSDate *FechaFin = [self DameFechaFin:aMedicina.drugScheduleTime.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];
    
    NSMutableArray *ArrayHorarios = [DrugTimeTakeDALC DameTomasOrdenadas:aMedicina];
    
    for (int i = 0; i < DiferenciaDias; i++) {
        
        for (int j = 0 ; j < [ArrayHorarios count]; j ++) {
            
            DrugScheduleCustomTake *objDALC = [ArrayHorarios objectAtIndex:j];
            NSDate *Fecha = [OSP_DateManager CombinaHoras:objDALC.time conFecha:FechaInicio en24horas:YES conSisHorario:nil];
            [NotificacionesDALC InsertarNuevaNotificacionDeMedicina:aMedicina EnFecha:[Fecha dateByAddingTimeInterval:i*60*60*24] ConDosis:objDALC.dose];
            
        }
    }
}


#pragma mark - Interval Meds Tests

+ (NSMutableArray *)CalculaArrayTomasIntervalTest:(Test *)aTest ConInterrupcion:(BOOL)aInterrupcion{
    
    int Tomas = 24/[aTest.testScheduleInterval.interval intValue];
    
    NSDate *PrimeraToma = [OSP_DateManager CombinaHoras:aTest.testScheduleInterval.firstMeasure conFecha:[NSDate date] en24horas:YES conSisHorario:nil];
    NSDate *BedTime = [OSP_DateManager CombinaHoras:aTest.testScheduleInterval.bedTime conFecha:[NSDate date] en24horas:YES conSisHorario:nil];
    
    NSMutableArray *arrayTomas = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < Tomas; i++) {
        
        NSLog(@"hora %@",PrimeraToma);
        
        if (!aInterrupcion) {
            [arrayTomas addObject:PrimeraToma];
        }else if ([OSP_DateManager DameDiferenciaDeHorasDe:PrimeraToma conFechaFinal:BedTime] > 0 ) {
            [arrayTomas addObject:PrimeraToma];
        }
        
        PrimeraToma = [PrimeraToma dateByAddingTimeInterval:60*60*[aTest.testScheduleInterval.interval intValue]];
        
    }
    
    return arrayTomas;
}

+ (NSMutableArray *)CalculaArrayTomasIntervalMeds:(Drug *)aMedicina ConInterrupcion:(BOOL)aInterrupcion{
    
    int Tomas = 24/[aMedicina.drugScheduleInterval.interval intValue];
    
    NSDate *PrimeraToma = [OSP_DateManager CombinaHoras:aMedicina.drugScheduleInterval.firstIntake conFecha:[NSDate date] en24horas:YES conSisHorario:nil];
    NSDate *BedTime = [OSP_DateManager CombinaHoras:aMedicina.drugScheduleInterval.bedTime conFecha:[NSDate date] en24horas:YES conSisHorario:nil];
    
    NSMutableArray *arrayTomas = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < Tomas; i++) {
        
        NSLog(@"hora %@",PrimeraToma);
        
        if (!aInterrupcion) {
            [arrayTomas addObject:PrimeraToma];
        }else if ([OSP_DateManager DameDiferenciaDeHorasDe:PrimeraToma conFechaFinal:BedTime] > 0 ) {
            [arrayTomas addObject:PrimeraToma];
        }
        
        PrimeraToma = [PrimeraToma dateByAddingTimeInterval:60*60*[aMedicina.drugScheduleInterval.interval intValue]];
        
    }

    return arrayTomas;
}


+ (void)CalcularNotificacionesIntervalTest:(Test *)aTest{
    
    NSDate *FechaInicio = [self DameFechaInicio:aTest.testScheduleInterval.startDate];
    
    if (!FechaInicio)
        return;
    
    
    [self EliminarNotificacionesPorTest:aTest];
    
    NSDate *FechaFin = [self DameFechaFin:aTest.testScheduleInterval.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];
    
    NSMutableArray *ArrayHorarios = [[[NSMutableArray alloc] initWithArray:[self CalculaArrayTomasIntervalTest:aTest ConInterrupcion:[aTest.testScheduleInterval.interuption intValue]]] autorelease];
    
    
    for (int i = 0; i < DiferenciaDias; i++) {
        
        for (int j = 0 ; j < [ArrayHorarios count]; j ++) {
            
            NSDate *Fecha = [ArrayHorarios objectAtIndex:j];
            [NotificacionesDALC InsertarNuevaNotificacionDeTest:aTest EnFecha:[Fecha dateByAddingTimeInterval:i*60*60*24] ConDosis:aTest.default1];
            
        }
    }
    
}


+ (void)CalcularNotificacionesInterval:(Drug *)aMedicina{
    
    NSDate *FechaInicio = [self DameFechaInicio:aMedicina.drugScheduleInterval.startDate];
    
    if (!FechaInicio) 
        return;
    
    
    [self EliminarNotificacionesPorMedicina:aMedicina];
    
    NSDate *FechaFin = [self DameFechaFin:aMedicina.drugScheduleInterval.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];
    
    NSMutableArray *ArrayHorarios = [[[NSMutableArray alloc] initWithArray:[self CalculaArrayTomasIntervalMeds:aMedicina ConInterrupcion:[aMedicina.drugScheduleInterval.interuption intValue]]] autorelease];
    
    
    for (int i = 0; i < DiferenciaDias; i++) {
        
        for (int j = 0 ; j < [ArrayHorarios count]; j ++) {
            
            NSDate *Fecha = [ArrayHorarios objectAtIndex:j];
            [NotificacionesDALC InsertarNuevaNotificacionDeMedicina:aMedicina EnFecha:[Fecha dateByAddingTimeInterval:i*60*60*24] ConDosis:aMedicina.drugScheduleInterval.dose];
            
        }
    }
    
}



#pragma mark - custom Meds Test

+ (void)CalcularNotificacionesCustomTest:(Test *)aTest{
    
    NSDate *FechaInicio = [self DameFechaInicio:aTest.testScheduleCustom.startDate];
    
    if (!FechaInicio)
        return;
    
    
    [self EliminarNotificacionesPorTest:aTest];
    
    NSDate *FechaFin = [self DameFechaFin:aTest.testScheduleCustom.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];
    
    int index = 0;
    
    TestScheduleCustomBE *objCustom = [TranslateClassDataModel TranslateCustomTest:aTest.testScheduleCustom];
    NSArray *arrayDias = objCustom.testScheduleCustomDays;
    
    if ([arrayDias count] == 0)
        return;
    
    for (int i = 0; i < DiferenciaDias ; i++) {
        
        TestScheduleCustomDayBE *objDay = [arrayDias objectAtIndex:index];
        for (int j = 0 ; j < [objDay.testScheduleCustomMeasures count]; j++) {
            
            TestScheduleCustomMeasureBE *objTake = [objDay.testScheduleCustomMeasures objectAtIndex:j];
            NSDate *HoraNotificacion = [OSP_DateManager CombinaHoras:objTake.time conFecha:FechaInicio en24horas:YES conSisHorario:nil];
            NSDate *FechaNoti = [HoraNotificacion dateByAddingTimeInterval:60*60*24*i];
            [NotificacionesDALC InsertarNuevaNotificacionDeTest:aTest EnFecha:FechaNoti ConDosis:aTest.default1];
        }
        
        index++;
        if (index == [aTest.testScheduleCustom.noMeasures intValue]) {
            index = 0;
        }
        
    }
}


+ (void)CalcularNotificacionesCustom:(Drug *)aMedicina{
    
    NSDate *FechaInicio = [self DameFechaInicio:aMedicina.drugScheduleCustom.startDate];
    
    if (!FechaInicio) 
        return;
    
    
    [self EliminarNotificacionesPorMedicina:aMedicina];
    
    NSDate *FechaFin = [self DameFechaFin:aMedicina.drugScheduleCustom.endDate];
    
    int DiferenciaDias = 1 + [OSP_DateManager DameDiferenciaDeDiasDe:FechaInicio conFechaFinal:FechaFin];

    int index = 0;
    
    ScheduleCustomBE *objCustom = [TranslateClassDataModel TranslateCustom:aMedicina.drugScheduleCustom];
    NSArray *arrayDias = objCustom.ArrayScheduleCustomDays;
    
    if ([arrayDias count] == 0)
        return;
    
    for (int i = 0; i < DiferenciaDias ; i++) {
        
        ScheduleCustomDayBE *objDay = [arrayDias objectAtIndex:index];
        for (int j = 0 ; j < [objDay.ArrayScheduleCustomTakes count]; j++) {
            
            ScheduleCustomTakeBE *objTake = [objDay.ArrayScheduleCustomTakes objectAtIndex:j];
            NSDate *HoraNotificacion = [OSP_DateManager CombinaHoras:objTake.time conFecha:FechaInicio en24horas:YES conSisHorario:nil];
            NSDate *FechaNoti = [HoraNotificacion dateByAddingTimeInterval:60*60*24*i]; 
            [NotificacionesDALC InsertarNuevaNotificacionDeMedicina:aMedicina EnFecha:FechaNoti ConDosis:objTake.dose];
        }
        
        index++;
        if (index == [aMedicina.drugScheduleCustom.noDays intValue]) {
            index = 0;
        }
        
    }
}



+ (void)ActualizarNotificacion:(Notificaciones *)objNoti{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //[objNoti setEstado:[NSNumber numberWithInt:0]];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO ACTUALIZAR LAS NOTIFICACIONES: %@", [error localizedDescription]);
    }
}

+ (NSMutableArray *)ListarTodasLasNotificacionesPendientes{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"estado >= %@  AND fechaHora >= %@",[NSNumber numberWithInt:1],[NSDate date]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
}

+ (NSMutableArray *)Listar{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
	[fetchRequest setEntity:entity];
	NSArray *array =  [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"fechaHora" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
}


+ (Notificaciones *)ObtenerNotificacionPorIdDrug:(Drug *)aDrug enFecha:(NSDate *)aFecha{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * moc = [appDelegate managedObjectContext];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:moc];
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"drug == %@ AND fechaHora == %@",aDrug,aFecha];
    [request setPredicate:predicate];
    NSArray *arrayMed = [moc executeFetchRequest:request error:nil];
    if ([arrayMed count] == 0) {
        return nil;
    }
    
    return [arrayMed objectAtIndex:0];
}


+ (Notificaciones *)ObtenerNotificacionPorIdTest:(Test *)aTest enFecha:(NSDate *)aFecha{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * moc = [appDelegate managedObjectContext];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:moc];
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"test == %@ AND fechaHora == %@",aTest,aFecha];
    [request setPredicate:predicate];
    NSArray *arrayMed = [moc executeFetchRequest:request error:nil];
    if ([arrayMed count] == 0) {
        return nil;
    }
    
    return [arrayMed objectAtIndex:0];
}


+ (void)CrearNuevaNotificacion{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSArray *arrayAux = [[[NSArray alloc] initWithArray:[self ListarTodasLasNotificacionesPendientes]] autorelease];
    if ([arrayAux count] == 0) {
        return;
    }
    
    Notificaciones *objAux = [arrayAux objectAtIndex:0];
    
    
    NSMutableArray *arrayNotificacionesParaLanzar = [self ListarNotificacionesDeMismaFecha:objAux.fechaHora];
    
  
    for (int i = 0; i < [arrayNotificacionesParaLanzar count]; i++) {
        
        UILocalNotification *localNotif = [[[UILocalNotification alloc] init] autorelease];
        
        Notificaciones *objNotificacion = [arrayNotificacionesParaLanzar objectAtIndex:i];
        
        localNotif.fireDate = objNotificacion.fechaHora;
        //localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        NSMutableDictionary *infoDict = [[[NSMutableDictionary alloc] init] autorelease];
        
        if (objNotificacion.drug) {
            localNotif.alertBody = [NSString stringWithFormat:@"%@   %@, %.2f Units",[OSP_DateManager CambiaFechaA24Horas:objNotificacion.fechaHora ConFormato:@"MMM, dd yyyy  "],objNotificacion.drug.drugName,[objNotificacion.dosis floatValue]];
            [infoDict setObject:[NSNumber numberWithInt:[objNotificacion.drug.drugPK intValue]] forKey:@"CodDrug"];
        }else{
            
            localNotif.alertBody = [NSString stringWithFormat:@"%@   %@ Test",[OSP_DateManager CambiaFechaA24Horas:objNotificacion.fechaHora ConFormato:@"MMM, dd yyyy  "],objNotificacion.test.testName];
            [infoDict setObject:[NSNumber numberWithInt:[objNotificacion.test.testID intValue]] forKey:@"CodTest"];
        }
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber+=1;
        
        [infoDict setObject:objNotificacion.fechaHora forKey:@"Fecha"];
        localNotif.userInfo = infoDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        
    }
    
}


+ (void)CrearNuevaNotificacionPara:(Drug *)aDrug EnFecha:(NSDate *)aFecha ConTexto:(NSString *)aTexto{
    

    UILocalNotification *localNotif = [[[UILocalNotification alloc] init] autorelease];
    
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:10];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    

    localNotif.alertBody = [NSString stringWithFormat:@"You have %.2f Pills of %@ left. A prescription is needed",[aDrug.pillsLeft floatValue],aDrug.drugName];

    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}


+ (NSMutableArray *)ListarNotificacionesDeMismaFecha:(NSDate *)aFecha{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notificaciones" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fechaHora == %@ AND estado >= %@",aFecha,[NSNumber numberWithInt:1]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    return arrayNoti;
}

@end
