//
//  TestBE.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestScheduleTimeBE.h"
#import "TestScheduleIntervalBE.h"
#import "TestScheduleCustomBE.h"

@interface TestBE : NSObject

@property (readwrite, retain) NSNumber * addedByUser;
@property (readwrite, retain) NSNumber * testID;
@property (readwrite, retain) NSNumber * default1;
@property (readwrite, retain) NSNumber * default2;
@property (readwrite, retain) NSString * gender;
@property (readwrite, retain) NSNumber * line11;
@property (readwrite, retain) NSNumber * line12;
@property (readwrite, retain) NSNumber * line13;
@property (readwrite, retain) NSNumber * line21;
@property (readwrite, retain) NSNumber * line22;
@property (readwrite, retain) NSNumber * line23;
@property (readwrite, retain) NSString * range1;
@property (readwrite, retain) NSString * range2;
@property (readwrite, retain) NSNumber * step1;
@property (readwrite, retain) NSNumber * step2;
@property (readwrite, retain) NSString * testName;
@property (readwrite, retain) NSNumber * testScheduleType;
@property (readwrite, retain) NSString * unit1;
@property (readwrite, retain) NSString * unit2;
@property (readwrite, retain) TestScheduleCustomBE *testScheduleCustomBE;
@property (readwrite, retain) TestScheduleIntervalBE *testScheduleIntervalBE;
@property (readwrite, retain) TestScheduleTimeBE *testScheduleTimeBE;
@end
