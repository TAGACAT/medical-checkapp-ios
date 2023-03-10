//
//  Drug.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugScheduleCustom, DrugScheduleInterval, DrugScheduleTime, Notificaciones;

@interface Drug : NSManagedObject

@property (nonatomic, retain) NSString * activIngred;
@property (nonatomic, retain) NSNumber * appINo;
@property (nonatomic, retain) NSString * dosage;
@property (nonatomic, retain) NSString * drugName;
@property (nonatomic, retain) NSNumber * drugPK;
@property (nonatomic, retain) NSNumber * drugScheduleType;
@property (nonatomic, retain) NSString * form;
@property (nonatomic, retain) NSNumber * packageSize;
@property (nonatomic, retain) NSNumber * pillsLeft;
@property (nonatomic, retain) NSNumber * refillAlarm;
@property (nonatomic, retain) NSNumber * triggerUnitsLeft;
@property (nonatomic, retain) DrugScheduleCustom *drugScheduleCustom;
@property (nonatomic, retain) DrugScheduleInterval *drugScheduleInterval;
@property (nonatomic, retain) DrugScheduleTime *drugScheduleTime;
@property (nonatomic, retain) NSSet *notificacion;
@end

@interface Drug (CoreDataGeneratedAccessors)

- (void)addNotificacionObject:(Notificaciones *)value;
- (void)removeNotificacionObject:(Notificaciones *)value;
- (void)addNotificacion:(NSSet *)values;
- (void)removeNotificacion:(NSSet *)values;

@end
