//
//  DrugScheduleCustom.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugScheduleCustomDay;

@interface DrugScheduleCustom : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * noDays;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSManagedObject *drug;
@property (nonatomic, retain) NSSet *drugScheduleCustomDay;
@end

@interface DrugScheduleCustom (CoreDataGeneratedAccessors)

- (void)addDrugScheduleCustomDayObject:(DrugScheduleCustomDay *)value;
- (void)removeDrugScheduleCustomDayObject:(DrugScheduleCustomDay *)value;
- (void)addDrugScheduleCustomDay:(NSSet *)values;
- (void)removeDrugScheduleCustomDay:(NSSet *)values;

@end
