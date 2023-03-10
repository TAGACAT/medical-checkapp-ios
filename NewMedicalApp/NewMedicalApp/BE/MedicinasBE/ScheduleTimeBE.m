//
//  ScheduleTimeBE.m
//  MedicalCheckApp
//
//

#import "ScheduleTimeBE.h"

@implementation ScheduleTimeBE

@synthesize endDate;
@synthesize noTake;
@synthesize startDate;
@synthesize arrayScheduleTimeTake;


-(id)init{
    
    return self;
}

-(void)dealloc{
    
    [endDate release];
    [noTake release];
    [startDate release];
    [arrayScheduleTimeTake release];
    [super dealloc];
}

@end
