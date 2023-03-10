//
//  ComentariosDALC.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import "AppDelegate.h"
#import "Notificaciones.h"
#import "CommentBE.h"

@interface ComentariosDALC : NSObject

+ (Comment *)Agregar:(CommentBE *)aComentario;
+ (NSMutableArray *)ListarComentarios:(Notificaciones *)aNotificacion;

@end
