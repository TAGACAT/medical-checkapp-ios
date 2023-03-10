//
//  Notificaciones.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Drug, Test;

@interface Notificaciones : NSManagedObject

@property (nonatomic, retain) NSNumber * dosis;
@property (nonatomic, retain) NSNumber * estado;
@property (nonatomic, retain) NSDate * fechaHora;
@property (nonatomic, retain) NSNumber * identificador;
@property (nonatomic, retain) Drug *drug;
@property (nonatomic, retain) Test *test;
@property (nonatomic, retain) NSSet *comentarios;
@end

@interface Notificaciones (CoreDataGeneratedAccessors)

- (void)addComentariosObject:(Comment *)value;
- (void)removeComentariosObject:(Comment *)value;
- (void)addComentarios:(NSSet *)values;
- (void)removeComentarios:(NSSet *)values;

@end
