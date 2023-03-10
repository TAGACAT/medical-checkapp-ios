//
//  ScheduleCustomDayBE.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "ScheduleCustomDayBE.h"

@implementation ScheduleCustomDayBE

@synthesize dayNumber;
@synthesize noDay;
@synthesize ArrayScheduleCustomTakes;


-(id)init{
    return self;
}


-(void)dealloc{
    
    [dayNumber release];
    [noDay release];
    [ArrayScheduleCustomTakes release];
    [super dealloc];
}

@end
