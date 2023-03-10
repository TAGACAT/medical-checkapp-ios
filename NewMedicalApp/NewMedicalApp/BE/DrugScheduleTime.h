//
//  DrugScheduleTime.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drug, DrugScheduleTimeTake;

@interface DrugScheduleTime : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * noTakes;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Drug *drug;
@property (nonatomic, retain) NSSet *drugScheduleTimeTake;
@end

@interface DrugScheduleTime (CoreDataGeneratedAccessors)

- (void)addDrugScheduleTimeTakeObject:(DrugScheduleTimeTake *)value;
- (void)removeDrugScheduleTimeTakeObject:(DrugScheduleTimeTake *)value;
- (void)addDrugScheduleTimeTake:(NSSet *)values;
- (void)removeDrugScheduleTimeTake:(NSSet *)values;

@end
