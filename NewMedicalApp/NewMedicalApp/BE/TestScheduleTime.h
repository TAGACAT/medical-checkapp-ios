//
//  TestScheduleTime.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test, TestScheduleTimeMeasure;

@interface TestScheduleTime : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * noMeasures;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Test *test;
@property (nonatomic, retain) NSSet *testScheduleTimeMeasure;
@end

@interface TestScheduleTime (CoreDataGeneratedAccessors)

- (void)addTestScheduleTimeMeasureObject:(TestScheduleTimeMeasure *)value;
- (void)removeTestScheduleTimeMeasureObject:(TestScheduleTimeMeasure *)value;
- (void)addTestScheduleTimeMeasure:(NSSet *)values;
- (void)removeTestScheduleTimeMeasure:(NSSet *)values;

@end
