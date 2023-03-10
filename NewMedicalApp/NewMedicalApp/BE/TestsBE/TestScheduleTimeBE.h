//
//  TestScheduleTimeBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestScheduleTimeBE : NSObject

@property (readwrite, retain) NSDate * endDate;
@property (readwrite, retain) NSNumber * noMeasures;
@property (readwrite, retain) NSDate * startDate;
@property (readwrite, retain) NSMutableArray *testScheduleTimeMeasures;
@end
