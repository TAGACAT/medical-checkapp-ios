//
//  DrugScheduleCustomTake.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugScheduleCustomDay;

@interface DrugScheduleCustomTake : NSManagedObject

@property (nonatomic, retain) NSNumber * dose;
@property (nonatomic, retain) NSNumber * takeNumber;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) DrugScheduleCustomDay *drugScheduleCustomDay;

@end
