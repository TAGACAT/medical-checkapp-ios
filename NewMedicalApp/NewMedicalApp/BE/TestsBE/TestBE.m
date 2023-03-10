//
//  TestBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestBE.h"

@implementation TestBE
@synthesize addedByUser;
@synthesize testID;
@synthesize default1;
@synthesize default2;
@synthesize gender;
@synthesize line11;
@synthesize line12;
@synthesize line13;
@synthesize line21;
@synthesize line22;
@synthesize line23;
@synthesize range1;
@synthesize range2;
@synthesize step1;
@synthesize step2;
@synthesize testName;
@synthesize testScheduleType;
@synthesize unit1;
@synthesize unit2;
@synthesize testScheduleCustomBE;
@synthesize testScheduleIntervalBE;
@synthesize testScheduleTimeBE;

-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [addedByUser release];
    [default1 release];
    [default2 release];
    [gender release];
    [line11 release];
    [line12 release];
    [line13 release];
    [line21 release];
    [line22 release];
    [line23 release];
    [range1 release];
    [range2 release];
    [step1 release];
    [step2 release];
    [testName release];
    [testScheduleType release];
    [unit1 release];
    [unit2 release];
    [testScheduleTimeBE release];
    [testScheduleIntervalBE release];
    [testScheduleCustomBE release];
    [super dealloc];
}

@end
