//
//  TestScheduleCustomDay.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestScheduleCustom, TestScheduleCustomMeasure;

@interface TestScheduleCustomDay : NSManagedObject

@property (nonatomic, retain) NSNumber * dayNumber;
@property (nonatomic, retain) NSNumber * noDays;
@property (nonatomic, retain) TestScheduleCustom *testScheduleCustom;
@property (nonatomic, retain) NSSet *testScheduleCustomMeasure;
@end

@interface TestScheduleCustomDay (CoreDataGeneratedAccessors)

- (void)addTestScheduleCustomMeasureObject:(TestScheduleCustomMeasure *)value;
- (void)removeTestScheduleCustomMeasureObject:(TestScheduleCustomMeasure *)value;
- (void)addTestScheduleCustomMeasure:(NSSet *)values;
- (void)removeTestScheduleCustomMeasure:(NSSet *)values;

@end
