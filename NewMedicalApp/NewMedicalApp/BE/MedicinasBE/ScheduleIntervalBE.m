//
//  ScheduleIntervalBE.m
//  MedicalCheckApp
//
//

#import "ScheduleIntervalBE.h"

@implementation ScheduleIntervalBE


@synthesize bedTime;
@synthesize dose;
@synthesize endDate;
@synthesize firstIntake;
@synthesize interuption;
@synthesize interval;
@synthesize startDate;

-(id)init{
    return self;
}

-(void)dealloc{
    
    [bedTime release];
    [dose release];
    [endDate release];
    [startDate release];
    [firstIntake release];
    [interuption release];
    [interval release];
    
    [super dealloc];
}

@end
