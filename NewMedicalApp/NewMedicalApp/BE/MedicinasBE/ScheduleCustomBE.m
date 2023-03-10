//
//  ScheduleCustomBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleCustomBE.h"

@implementation ScheduleCustomBE

@synthesize endDate;
@synthesize noDays;
@synthesize startDate;
@synthesize ArrayScheduleCustomDays;

-(id)init{
    return self;
}

-(void)dealloc{
    
    [endDate release];
    [noDays release];
    [startDate release];
    [ArrayScheduleCustomDays release];
    [super dealloc];
}

@end
