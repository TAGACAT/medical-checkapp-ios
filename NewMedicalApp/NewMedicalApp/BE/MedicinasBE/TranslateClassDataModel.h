//
//  TranslateClassDataModel.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderDrugBE.h"
#import "HeaderTestBE.h"


@interface TranslateClassDataModel : NSObject


+ (MedicinaBE *)TranslateMedicina:(Drug *)objMedicina;

+ (ScheduleCustomBE *)TranslateCustom:(DrugScheduleCustom *)objCustom;
+ (ScheduleCustomDayBE *)TranslateCustomDay:(DrugScheduleCustomDay *)objCustomDay;
+ (ScheduleCustomTakeBE *)TranslateCustomTake:(DrugScheduleCustomTake *)objCustomTake;

+ (ScheduleTimeBE *)TranslateScheduleTime:(DrugScheduleTime *)objTime;
+ (ScheduleTimeTakeBE *)TranslateScheduleTimeTake:(DrugScheduleTimeTake *)objTimeTake;

+ (ScheduleIntervalBE *)TranslateScheduleInterval:(DrugScheduleInterval *)objInterval;



//****************** TEST ********************


+ (TestBE *)TranslateTest:(Test *)objTest;

+ (TestScheduleCustomBE *)TranslateCustomTest:(TestScheduleCustom *)objCustom;
+ (TestScheduleCustomDayBE *)TranslateCustomDayTest:(TestScheduleCustomDay *)objCustomDay;
+ (TestScheduleCustomMeasureBE *)TranslateCustomMeasureTest:(TestScheduleCustomMeasure *)objCustomTake;

+ (TestScheduleTimeBE *)TranslateScheduleTimeTest:(TestScheduleTime *)objTime;
+ (TestScheduleTimeMeasureBE *)TranslateScheduleTimeMeasureTest:(TestScheduleTimeMeasure *)objTimeTake;

+ (TestScheduleIntervalBE *)TranslateScheduleIntervalTest:(TestScheduleInterval *)objInterval;

@end
