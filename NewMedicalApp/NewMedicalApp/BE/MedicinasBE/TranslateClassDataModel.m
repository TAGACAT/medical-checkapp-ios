//
//  TranslateClassDataModel.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "TranslateClassDataModel.h"

@implementation TranslateClassDataModel


#pragma mark - test


+ (TestBE *)TranslateTest:(Test *)objTest{
    
    TestBE *objBE = [[[TestBE alloc] init] autorelease];
    [objBE setAddedByUser:objTest.addedByUser];
    [objBE setTestID:objTest.testID];
    [objBE setDefault1:objTest.default1];
    [objBE setDefault2:objTest.default2];
    [objBE setGender:objTest.gender];
    [objBE setLine11:objTest.line11];
    [objBE setLine12:objTest.line12];
    [objBE setLine13:objTest.line13];
    [objBE setLine21:objTest.line21];
    [objBE setLine22:objTest.line22];
    [objBE setLine23:objTest.line23];
    [objBE setRange1:objTest.range1];
    [objBE setRange2:objTest.range2];
    [objBE setStep1:objTest.step1];
    [objBE setStep2:objTest.step2];
    [objBE setTestName:objTest.testName];
    [objBE setTestScheduleType:objTest.testScheduleType];
    [objBE setUnit1:objTest.unit1];
    [objBE setUnit2:objTest.unit2];
    
    if (objTest.testScheduleTimeTake)
        [objBE setTestScheduleTimeBE:[self TranslateScheduleTimeTest:objTest.testScheduleTimeTake]];
    
    if (objTest.testScheduleInterval)
        [objBE setTestScheduleIntervalBE:[self TranslateScheduleIntervalTest:objTest.testScheduleInterval]];
    
    if (objTest.testScheduleCustom)
        [objBE setTestScheduleCustomBE:[self TranslateCustomTest:objTest.testScheduleCustom]];
    
    
    return objBE;
}



+ (TestScheduleCustomBE *)TranslateCustomTest:(TestScheduleCustom *)objCustom{
    
    TestScheduleCustomBE *objBE = [[[TestScheduleCustomBE alloc] init] autorelease];
    [objBE setEndDate:objCustom.endDate];
    [objBE setNoMeasures:objCustom.noMeasures];
    [objBE setStartDate:objCustom.startDate];
    
    NSMutableArray *arrayDays = [[[NSMutableArray alloc] init] autorelease];
    
    for (TestScheduleCustomDay *CustomDay in objCustom.testScheduleCustomDay)
        [arrayDays addObject:[self TranslateCustomDayTest:CustomDay]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"dayNumber" ascending:YES] autorelease];
    [arrayDays sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setTestScheduleCustomDays:arrayDays];
    
    return objBE;
}


+ (TestScheduleCustomDayBE *)TranslateCustomDayTest:(TestScheduleCustomDay *)objCustomDay{
    
    TestScheduleCustomDayBE *objBE = [[[TestScheduleCustomDayBE alloc] init] autorelease];
    [objBE setDayNumber:objCustomDay.dayNumber];
    [objBE setNoDays:objCustomDay.noDays];
    
    NSMutableArray *arrayTakes = [[[NSMutableArray alloc] init] autorelease];
    
    for (TestScheduleCustomMeasure *CustomTake in objCustomDay.testScheduleCustomMeasure)
        [arrayTakes addObject:[self TranslateCustomMeasureTest:CustomTake]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [arrayTakes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setTestScheduleCustomMeasures:arrayTakes];
    
    return objBE;
}


+ (TestScheduleCustomMeasureBE *)TranslateCustomMeasureTest:(TestScheduleCustomMeasure *)objCustomTake{
 
    TestScheduleCustomMeasureBE *objBE = [[[TestScheduleCustomMeasureBE alloc] init] autorelease];
    [objBE setMeasureNumber:objCustomTake.measureNumber];
    [objBE setTime:objCustomTake.time];
    
    return objBE;
}



+ (TestScheduleTimeBE *)TranslateScheduleTimeTest:(TestScheduleTime *)objTime{
    
    TestScheduleTimeBE *objBE =[[[TestScheduleTimeBE alloc] init] autorelease];
    [objBE setEndDate:objTime.endDate];
    [objBE setNoMeasures:objTime.noMeasures];
    [objBE setStartDate:objTime.startDate];
    
    NSMutableArray *arrayTakes = [[[NSMutableArray alloc] init] autorelease];
    
    for (TestScheduleTimeMeasure *TimeTake in objTime.testScheduleTimeMeasure)
        [arrayTakes addObject:[self TranslateScheduleTimeMeasureTest:TimeTake]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [arrayTakes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setTestScheduleTimeMeasures:arrayTakes];
    
    return objBE;
}


+ (TestScheduleTimeMeasureBE *)TranslateScheduleTimeMeasureTest:(TestScheduleTimeMeasure *)objTimeTake{
    
    TestScheduleTimeMeasureBE *objBE = [[[TestScheduleTimeMeasureBE alloc] init] autorelease];
    [objBE setMeasureNumber:objTimeTake.measureNumber];
    [objBE setTime:objTimeTake.time];
    
    return objBE;
}



+ (TestScheduleIntervalBE *)TranslateScheduleIntervalTest:(TestScheduleInterval *)objInterval{
    
    TestScheduleIntervalBE *objBE = [[[TestScheduleIntervalBE alloc] init] autorelease];
    [objBE setBedTime:objInterval.bedTime];
    [objBE setMeasureNumber:objInterval.measureNumber];
    [objBE setEndDate:objInterval.endDate];
    [objBE setFirstMeasure:objInterval.firstMeasure];
    [objBE setInterval:objInterval.interval];
    [objBE setInterruption:objInterval.interuption];
    [objBE setStartDate:objInterval.startDate];
    
    return objBE;
}



#pragma mark - medicina

+ (MedicinaBE *)TranslateMedicina:(Drug *)objMedicina{
    
    MedicinaBE *objBE = [[[MedicinaBE alloc] init] autorelease];
    [objBE setActivIngred:objMedicina.activIngred];
    [objBE setAppINo:objMedicina.appINo];
    [objBE setDosage:objMedicina.dosage];
    [objBE setDrugName:objMedicina.drugName];
    [objBE setDrugScheduleType:objMedicina.drugScheduleType];
    [objBE setDrugPK:objMedicina.drugPK];
    [objBE setForm:objMedicina.form];
    [objBE setPackageSize:objMedicina.packageSize];
    [objBE setPillsLeft:objMedicina.pillsLeft];
    [objBE setRefillAlarm:objMedicina.refillAlarm];
    [objBE setTriggerUnitsLeft:objMedicina.triggerUnitsLeft];
    
    if (objMedicina.drugScheduleTime)
        [objBE setObjScheduleTime:[self TranslateScheduleTime:objMedicina.drugScheduleTime]];
   
    if (objMedicina.drugScheduleInterval)
        [objBE setObjScheduleInter:[self TranslateScheduleInterval:objMedicina.drugScheduleInterval]];
    
    if (objMedicina.drugScheduleCustom)
        [objBE setObjScheduleCustom:[self TranslateCustom:objMedicina.drugScheduleCustom]];
    
    
    return objBE;
}

#pragma mark - schedule Custom

+ (ScheduleCustomBE *)TranslateCustom:(DrugScheduleCustom *)objCustom{
    
    ScheduleCustomBE *objBE = [[[ScheduleCustomBE alloc] init] autorelease];
    [objBE setEndDate:objCustom.endDate];
    [objBE setNoDays:objCustom.noDays];
    [objBE setStartDate:objCustom.startDate];
    
    NSMutableArray *arrayDays = [[[NSMutableArray alloc] init] autorelease];
    
    for (DrugScheduleCustomDay *CustomDay in objCustom.drugScheduleCustomDay)  
        [arrayDays addObject:[self TranslateCustomDay:CustomDay]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"noDay" ascending:YES] autorelease];
    [arrayDays sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setArrayScheduleCustomDays:arrayDays];
    
    return objBE;
}


+ (ScheduleCustomDayBE *)TranslateCustomDay:(DrugScheduleCustomDay *)objCustomDay{
    
    ScheduleCustomDayBE *objBE = [[[ScheduleCustomDayBE alloc] init] autorelease];
    [objBE setDayNumber:objCustomDay.dayNumber];
    [objBE setNoDay:objCustomDay.noDay];
    
    NSMutableArray *arrayTakes = [[[NSMutableArray alloc] init] autorelease];
    
    for (DrugScheduleCustomTake *CustomTake in objCustomDay.drugScheduleCustomTake)  
        [arrayTakes addObject:[self TranslateCustomTake:CustomTake]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [arrayTakes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setArrayScheduleCustomTakes:arrayTakes];
    
    return objBE;
}


+ (ScheduleCustomTakeBE *)TranslateCustomTake:(DrugScheduleCustomTake *)objCustomTake{
    
    ScheduleCustomTakeBE *objBE = [[[ScheduleCustomTakeBE alloc] init] autorelease];
    [objBE setDose:objCustomTake.dose];
    [objBE setTakeNumber:objCustomTake.takeNumber];
    [objBE setTime:objCustomTake.time];
    
    return objBE;
}

#pragma mark - schedule Time

+ (ScheduleTimeBE *)TranslateScheduleTime:(DrugScheduleTime *)objTime{
    
    ScheduleTimeBE *objBE =[[[ScheduleTimeBE alloc] init] autorelease];
    [objBE setEndDate:objTime.endDate];
    [objBE setNoTake:objTime.noTakes];
    [objBE setStartDate:objTime.startDate];
    
    NSMutableArray *arrayTakes = [[[NSMutableArray alloc] init] autorelease];
    
    for (DrugScheduleTimeTake *TimeTake in objTime.drugScheduleTimeTake)  
        [arrayTakes addObject:[self TranslateScheduleTimeTake:TimeTake]];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES] autorelease];
    [arrayTakes sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    [objBE setArrayScheduleTimeTake:arrayTakes];
    
    return objBE;
}


+ (ScheduleTimeTakeBE *)TranslateScheduleTimeTake:(DrugScheduleTimeTake *)objTimeTake{
    
    ScheduleTimeTakeBE *objBE = [[[ScheduleTimeTakeBE alloc] init] autorelease];
    [objBE setDose:objTimeTake.dose];
    [objBE setTakeNumber:objTimeTake.takeNumber];
    [objBE setTime:objTimeTake.time];
    
    return objBE;
}


#pragma mark - schedule Interval

+ (ScheduleIntervalBE *)TranslateScheduleInterval:(DrugScheduleInterval *)objInterval{
    
    ScheduleIntervalBE *objBE = [[[ScheduleIntervalBE alloc] init] autorelease];
    [objBE setBedTime:objInterval.bedTime];
    [objBE setDose:objInterval.dose];
    [objBE setEndDate:objInterval.endDate];
    [objBE setFirstIntake:objInterval.firstIntake];
    [objBE setInterval:objInterval.interval];
    [objBE setInteruption:objInterval.interuption];
    [objBE setStartDate:objInterval.startDate];
    
    return objBE;
}


#pragma mark -


@end
