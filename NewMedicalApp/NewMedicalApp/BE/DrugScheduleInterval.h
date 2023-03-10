//
//  DrugScheduleInterval.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DrugScheduleInterval : NSManagedObject

@property (nonatomic, retain) NSString * bedTime;
@property (nonatomic, retain) NSNumber * dose;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * firstIntake;
@property (nonatomic, retain) NSNumber * interuption;
@property (nonatomic, retain) NSNumber * interval;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSManagedObject *drug;

@end
