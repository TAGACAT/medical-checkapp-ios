//
//  TestScheduleTimeMeasureBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScheduleTimeMeasureBE.h"

@implementation TestScheduleTimeMeasureBE

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
