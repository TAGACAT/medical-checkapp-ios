//
//  TestScheduleInterval.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test;

@interface TestScheduleInterval : NSManagedObject

@property (nonatomic, retain) NSString * bedTime;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * firstMeasure;
@property (nonatomic, retain) NSNumber * interuption;
@property (nonatomic, retain) NSNumber * interval;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * measureNumber;
@property (nonatomic, retain) Test *test;

@end
