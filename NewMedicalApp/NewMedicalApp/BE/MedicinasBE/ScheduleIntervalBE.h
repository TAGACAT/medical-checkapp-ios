//
//  ScheduleIntervalBE.h
//  MedicalCheckApp
//
//

#import <Foundation/Foundation.h>

@interface ScheduleIntervalBE : NSObject

@property (readwrite, retain) NSString * bedTime;
@property (readwrite, retain) NSNumber * dose;
@property (readwrite, retain) NSDate * endDate;
@property (readwrite, retain) NSString * firstIntake;
@property (readwrite, retain) NSNumber * interuption;
@property (readwrite, retain) NSNumber * interval;
@property (readwrite, retain) NSDate * startDate;

@end
