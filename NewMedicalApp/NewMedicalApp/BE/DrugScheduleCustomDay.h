//
//  DrugScheduleCustomDay.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugScheduleCustom, DrugScheduleCustomTake;

@interface DrugScheduleCustomDay : NSManagedObject

@property (nonatomic, retain) NSNumber * dayNumber;
@property (nonatomic, retain) NSNumber * noDay;
@property (nonatomic, retain) DrugScheduleCustom *drugScheduleCustom;
@property (nonatomic, retain) NSSet *drugScheduleCustomTake;
@end

@interface DrugScheduleCustomDay (CoreDataGeneratedAccessors)

- (void)addDrugScheduleCustomTakeObject:(DrugScheduleCustomTake *)value;
- (void)removeDrugScheduleCustomTakeObject:(DrugScheduleCustomTake *)value;
- (void)addDrugScheduleCustomTake:(NSSet *)values;
- (void)removeDrugScheduleCustomTake:(NSSet *)values;

@end
