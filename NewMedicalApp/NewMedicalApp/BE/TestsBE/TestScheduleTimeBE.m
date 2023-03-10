//
//  TestScheduleTimeBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleTimeBE.h"

@implementation TestScheduleTimeBE

@synthesize endDate;
@synthesize startDate;
@synthesize noMeasures;
@synthesize testScheduleTimeMeasures;

-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [endDate release];
    [startDate release];
    [noMeasures release];
    [testScheduleTimeMeasures release];
    [super dealloc];
}

@end
