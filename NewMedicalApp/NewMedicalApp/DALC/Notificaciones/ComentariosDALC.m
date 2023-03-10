//
//  ComentariosDALC.m
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComentariosDALC.h"

@implementation ComentariosDALC


+ (Comment *)Agregar:(CommentBE *)aComentario{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Comment *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setComment:aComentario.comment];
    [ObjDALC setCodigo:aComentario.codigo];
    [ObjDALC setCategoria:aComentario.categoria];
    [ObjDALC setSubCategoria:aComentario.subCategoria];
  
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){ 
        NSLog(@"NO SE PUDO AGREGAR EL COMENTARIO: %@", [error localizedDescription]);   
        return nil;
    }
    
    return ObjDALC;

}


+ (NSMutableArray *)ListarComentarios:(Notificaciones *)aNotificacion{
    
    return nil;
}

@end
