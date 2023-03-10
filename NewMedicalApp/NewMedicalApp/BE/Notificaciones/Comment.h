//
//  Comment.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Notificaciones;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * categoria;
@property (nonatomic, retain) NSString * subCategoria;
@property (nonatomic, retain) Notificaciones *notificacion;

@end
