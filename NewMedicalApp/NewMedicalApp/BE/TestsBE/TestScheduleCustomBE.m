//
//  TestScheduleCustomBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleCustomBE.h"

@implementation TestScheduleCustomBE

@synthesize endDate;
@synthesize startDate;
@synthesize noMeasures;
@synthesize testScheduleCustomDays;


-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [endDate release];
    [startDate release];
    [noMeasures release];
    [testScheduleCustomDays release];
    [super dealloc];
}

@end
