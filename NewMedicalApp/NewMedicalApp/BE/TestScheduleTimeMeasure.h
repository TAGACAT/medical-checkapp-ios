//
//  TestScheduleTimeMeasure.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TestScheduleTime;

@interface TestScheduleTimeMeasure : NSManagedObject

@property (nonatomic, retain) NSNumber * measureNumber;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) TestScheduleTime *testScheduleTime;

@end
