//
//  ScheduleCustomBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScheduleCustomBE : NSObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * noDays;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSMutableArray *ArrayScheduleCustomDays;

@end
