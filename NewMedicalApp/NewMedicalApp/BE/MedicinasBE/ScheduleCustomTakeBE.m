//
//  ScheduleCustomTake.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 Online Studio Productions. All rights reserved.
//

#import "ScheduleCustomTakeBE.h"

@implementation ScheduleCustomTakeBE

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
