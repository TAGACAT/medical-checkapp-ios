//
//  ScheduleTimeBE.h
//  MedicalCheckApp
//
//

#import <Foundation/Foundation.h>

@interface ScheduleTimeBE : NSObject

@property (readwrite, retain) NSDate * endDate;
@property (readwrite, retain) NSNumber * noTake;
@property (readwrite, retain) NSDate * startDate;
@property (readwrite, retain) NSMutableArray *arrayScheduleTimeTake;

@end
