//
//  TestScheduleCustomDayBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleCustomDayBE.h"

@implementation TestScheduleCustomDayBE

@synthesize dayNumber;
@synthesize noDays;
@synthesize testScheduleCustomMeasures;


-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [dayNumber release];
    [noDays release];
    [testScheduleCustomMeasures release];
    [super dealloc];
}

@end
