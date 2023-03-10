//
//  TestScheduleCustomBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestScheduleCustomBE : NSObject

@property (readwrite, retain) NSDate * endDate;
@property (readwrite, retain) NSDate *startDate;
@property (readwrite, retain) NSNumber *noMeasures;
@property (readwrite, retain) NSMutableArray *testScheduleCustomDays;


@end
