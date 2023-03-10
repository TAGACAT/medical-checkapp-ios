//
//  TestScheduleCustomMeasure.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestScheduleCustomDay;

@interface TestScheduleCustomMeasure : NSManagedObject

@property (nonatomic, retain) NSNumber * measureNumber;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) TestScheduleCustomDay *testScheduleCustomDay;

@end
