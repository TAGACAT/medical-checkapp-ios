//
//  TestScheduleIntervalBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleIntervalBE.h"

@implementation TestScheduleIntervalBE


@synthesize endDate;
@synthesize startDate;
@synthesize interval;
@synthesize interruption;
@synthesize bedTime;
@synthesize firstMeasure;
@synthesize measureNumber;

-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [measureNumber release];
    [endDate release];
    [startDate release];
    [firstMeasure release];
    [interval release];
    [interruption release];
    [bedTime release];
    [super dealloc];
}

@end
