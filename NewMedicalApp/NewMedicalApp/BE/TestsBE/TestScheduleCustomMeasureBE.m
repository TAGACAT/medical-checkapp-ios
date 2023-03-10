//
//  TestScheduleCustomMeasureBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleCustomMeasureBE.h"

@implementation TestScheduleCustomMeasureBE

@synthesize measureNumber;
@synthesize time;

-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [measureNumber release];
    [time release];
    [super dealloc];
}


@end
