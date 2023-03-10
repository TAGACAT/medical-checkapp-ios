//
//  ScheduleTimeTakeBE.m
//  MedicalCheckApp
//
//

#import "ScheduleTimeTakeBE.h"

@implementation ScheduleTimeTakeBE

@synthesize dose;
@synthesize takeNumber;
@synthesize time;


-(id)init{
    return self;
}

-(void)dealloc{
    
    [dose release];
    [takeNumber release];
    [time release];
    [super dealloc];
}

@end
