//
//  TestScheduleCustom.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test, TestScheduleCustomDay;

@interface TestScheduleCustom : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * noMeasures;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Test *test;
@property (nonatomic, retain) NSSet *testScheduleCustomDay;
@end

@interface TestScheduleCustom (CoreDataGeneratedAccessors)

- (void)addTestScheduleCustomDayObject:(TestScheduleCustomDay *)value;
- (void)removeTestScheduleCustomDayObject:(TestScheduleCustomDay *)value;
- (void)addTestScheduleCustomDay:(NSSet *)values;
- (void)removeTestScheduleCustomDay:(NSSet *)values;

@end
