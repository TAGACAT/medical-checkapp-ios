//
//  TestScheduleIntervalBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestScheduleIntervalBE : NSObject

@property (readwrite, retain) NSString * bedTime;
@property (readwrite, retain) NSDate * endDate;
@property (readwrite, retain) NSString *firstMeasure;
@property (readwrite, retain) NSNumber *interruption;
@property (readwrite, retain) NSNumber *interval;
@property (readwrite, retain) NSDate *startDate;
@property (nonatomic, retain) NSNumber * measureNumber;

@end
