//
//  MedicinaBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleTimeBE.h"
#import "ScheduleIntervalBE.h"
#import "ScheduleCustomBE.h"



@interface MedicinaBE : NSObject

@property (readwrite, retain) NSString * activIngred;
@property (readwrite, retain) NSNumber * appINo;
@property (readwrite, retain) NSString * dosage;
@property (readwrite, retain) NSString * drugName;
@property (readwrite, retain) NSNumber * drugScheduleType;
@property (readwrite, retain) NSNumber * drugPK;
@property (readwrite, retain) NSString * form;
@property (readwrite, retain) NSNumber * packageSize;
@property (readwrite, retain) NSNumber * pillsLeft;
@property (readwrite, retain) NSNumber * refillAlarm;
@property (readwrite, retain) NSNumber * triggerUnitsLeft;

@property (readwrite, retain) ScheduleTimeBE *objScheduleTime;
@property (readwrite, retain) ScheduleIntervalBE *objScheduleInter;
@property (readwrite, retain) ScheduleCustomBE *objScheduleCustom;


@end
