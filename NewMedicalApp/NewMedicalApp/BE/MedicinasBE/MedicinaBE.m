//
//  MedicinaBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "MedicinaBE.h"

@implementation MedicinaBE

@synthesize activIngred;
@synthesize appINo;
@synthesize dosage;
@synthesize drugName;
@synthesize drugScheduleType;
@synthesize drugPK;
@synthesize form;
@synthesize packageSize;
@synthesize pillsLeft;
@synthesize refillAlarm;
@synthesize triggerUnitsLeft;

@synthesize objScheduleTime;
@synthesize objScheduleInter;
@synthesize objScheduleCustom;

-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [activIngred release];
    [appINo release];
    [dosage release];
    [drugName release];
    [drugScheduleType release];
    [drugPK release];
    [form release];
    [packageSize release];
    [pillsLeft release];
    [refillAlarm release];
    [triggerUnitsLeft release];
    [objScheduleTime release];
    [objScheduleInter release];
    [objScheduleCustom release];
    
    [super dealloc];
}

@end
