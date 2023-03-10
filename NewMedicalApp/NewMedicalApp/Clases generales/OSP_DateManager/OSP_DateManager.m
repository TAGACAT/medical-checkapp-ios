//
//  OSP_DateManager.m
//  Fechas
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "OSP_DateManager.h"

@implementation OSP_DateManager


+ (NSDate *)Fecha{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    return [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
}

+ (NSDate *)FechaConHora{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
}

+ (NSDate *)CambiaTextoAFecha:(NSString *)aFecha AlFormato:(NSString *)aFormato{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:aFormato];
    return [dateFormat dateFromString:aFecha];
}


+ (NSString *)CambiaFechaA12Horas:(NSDate *)aFecha ConFormato:(NSString *)aFormato{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:[NSString stringWithFormat:@"%@ HH:mm:ss a",aFormato]];
    NSLog(@"%@",[dateFormat stringFromDate:aFecha]);
    return [dateFormat stringFromDate:aFecha];
}

+ (NSString *)CambiaFechaA24Horas:(NSDate *)aFecha ConFormato:(NSString *)aFormato{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:[NSString stringWithFormat:@"%@ HH:mm",aFormato]];
    NSLog(@"%@",[dateFormat stringFromDate:aFecha]);
    return [dateFormat stringFromDate:aFecha];
}


+ (NSString *)CambiaFecha:(NSDate *)aFecha AlFormato:(NSString *)aFormato{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:aFormato];
    NSLog(@"%@",[dateFormat stringFromDate:aFecha]);
    return [dateFormat stringFromDate:aFecha];
}


+ (float)DameDiferenciaDeHorasDe:(NSDate *)aFechaInicial conFechaFinal:(NSDate *)aFechaFinal{
    
    NSTimeInterval secondsBetween = [aFechaFinal timeIntervalSinceDate:aFechaInicial];
    float minutos = secondsBetween/60.0;
    float horas = minutos/60.0	;
    NSLog(@"Comparacion.......... %f",horas);
    return horas;
}


+ (int)DameDiferenciaDeDiasDe:(NSDate *)aFechaInicial conFechaFinal:(NSDate *)aFechaFinal{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *FechaInicial = [dateFormat stringFromDate:aFechaInicial];
    NSString *FechaFinal = [dateFormat stringFromDate:aFechaFinal];
    
    NSDate *dateIncial = [dateFormat dateFromString:FechaInicial];
    NSDate *dateFinal = [dateFormat dateFromString:FechaFinal];
    
    
    NSTimeInterval secondsBetween = [dateFinal timeIntervalSinceDate:dateIncial];
    int minutos = secondsBetween/60;
    int horas = minutos/60;
    int dias = horas/24;
    NSLog(@"Comparacion.......... %d",dias);
    return dias;
}



+ (NSString *)DameDiaDeLaSemana:(BOOL)conAbrev{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    
    if (conAbrev) 
        [dateFormat setDateFormat:@"EEE"];
    else 
        [dateFormat setDateFormat:@"EEEE"];
    
    return [dateFormat stringFromDate:[NSDate date]];
}




+ (NSTimeInterval)DameCantidadDeSegundosEnHora:(NSString *)aHora en24horas:(BOOL)aFormato conSisHorario:(NSString *)aSisHor{
    
    
    NSArray *arrayHoMin = [NSArray arrayWithArray:[aHora componentsSeparatedByString:@":"]];
         
    if ([arrayHoMin count] == 0 || [arrayHoMin count] > 2) 
        return 0;
    
    if (aFormato) {
        int horas = [[arrayHoMin objectAtIndex:0] intValue];
        int minutos = [[arrayHoMin objectAtIndex:1] intValue];
        NSLog(@"%d",(minutos*60 + horas*60*60));
        return minutos*60 + horas*60*60;
        
    }else {
        
        int horas = [[arrayHoMin objectAtIndex:0] intValue];
        int minutos = [[arrayHoMin objectAtIndex:1] intValue];
        
        if ([@"AM" isEqualToString:[aSisHor uppercaseString]]) {
            
            NSLog(@"%d",(minutos*60 + horas*60*60));
            return minutos*60 + horas*60*60;
            
        }else if ([@"PM" isEqualToString:[aSisHor uppercaseString]]) {
           
            NSLog(@"%d",(12*60*60 + minutos*60 + horas*60*60));
            return minutos*60 + horas*60*60 + 12*60*60;
        }
        
        return 0;
    }
    
}

+ (NSDate *)CombinaHoras:(NSString *)aHora conFecha:(NSDate *)aDate en24horas:(BOOL)aFormato conSisHorario:(NSString *)aSisHor{

    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *Fecha = [dateFormat stringFromDate:aDate];
    NSDate *fechaFinal = [dateFormat dateFromString:Fecha];
    
    NSTimeInterval intev = [self DameCantidadDeSegundosEnHora:aHora en24horas:aFormato conSisHorario:aSisHor];
    return [fechaFinal dateByAddingTimeInterval:intev];
     
}


+ (int)DameNumeroDiaDeFecha:(NSDate *)aFecha{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd"];
    return [[dateFormat stringFromDate:aFecha] intValue];
}


+ (int)DameNumeroMesDeFecha:(NSDate *)aFecha{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"MM"];
    return [[dateFormat stringFromDate:aFecha] intValue];
}

+ (int)DameNumeroAnioDeFecha:(NSDate *)aFecha{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"yyyy"];
    return [[dateFormat stringFromDate:aFecha] intValue];
}

+ (NSDate *)DameUltimoDiaDelMes:(NSDate *)aFecha{
    
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *FechaFinal = [dateFormat dateFromString:[NSString stringWithFormat:@"1-%d-%d",1 + [self DameNumeroMesDeFecha:aFecha],[self DameNumeroAnioDeFecha:aFecha]]];
    NSDate *FechaInicial = [dateFormat dateFromString:[NSString stringWithFormat:@"1-%d-%d",[self DameNumeroMesDeFecha:aFecha],[self DameNumeroAnioDeFecha:aFecha]]];
    int DiferenciaDias = [self DameDiferenciaDeDiasDe:FechaInicial conFechaFinal:FechaFinal];
    return [dateFormat dateFromString:[NSString stringWithFormat:@"%d-%d-%d",DiferenciaDias,[self DameNumeroMesDeFecha:aFecha],[self DameNumeroAnioDeFecha:aFecha]]];
}

+ (NSDate *)DamePrimerDiaDelMes:(NSDate *)aFecha{
   
    NSLocale *uslocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateStyle:NSDateFormatterBehaviorDefault];
    [dateFormat setLocale:uslocale];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *FechaFinal = [dateFormat dateFromString:[NSString stringWithFormat:@"1-%d-%d",[self DameNumeroMesDeFecha:aFecha],[self DameNumeroAnioDeFecha:aFecha]]];
    return FechaFinal;
}

- (id)init
{
    return self;
}

-(void)dealloc{
    
    [super dealloc];
}

@end
