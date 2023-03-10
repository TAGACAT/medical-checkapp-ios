//
//  Test.h
//  NewMedicalApp
//
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Notificaciones, TestScheduleCustom, TestScheduleInterval, TestScheduleTime;

@interface Test : NSManagedObject

@property (nonatomic, retain) NSNumber * addedByUser;
@property (nonatomic, retain) NSNumber * default1;
@property (nonatomic, retain) NSNumber * default2;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * line11;
@property (nonatomic, retain) NSNumber * line12;
@property (nonatomic, retain) NSNumber * line13;
@property (nonatomic, retain) NSNumber * line21;
@property (nonatomic, retain) NSNumber * line22;
@property (nonatomic, retain) NSNumber * line23;
@property (nonatomic, retain) NSString * range1;
@property (nonatomic, retain) NSString * range2;
@property (nonatomic, retain) NSNumber * step1;
@property (nonatomic, retain) NSNumber * step2;
@property (nonatomic, retain) NSNumber * testID;
@property (nonatomic, retain) NSString * testName;
@property (nonatomic, retain) NSNumber * testScheduleType;
@property (nonatomic, retain) NSString * unit1;
@property (nonatomic, retain) NSString * unit2;
@property (nonatomic, retain) NSSet *notificacion;
@property (nonatomic, retain) TestScheduleCustom *testScheduleCustom;
@property (nonatomic, retain) TestScheduleInterval *testScheduleInterval;
@property (nonatomic, retain) TestScheduleTime *testScheduleTimeTake;
@end

@interface Test (CoreDataGeneratedAccessors)

- (void)addNotificacionObject:(Notificaciones *)value;
- (void)removeNotificacionObject:(Notificaciones *)value;
- (void)addNotificacion:(NSSet *)values;
- (void)removeNotificacion:(NSSet *)values;

@end
