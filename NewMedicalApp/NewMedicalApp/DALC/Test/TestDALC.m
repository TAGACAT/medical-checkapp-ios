//
//  TestDALC.m
//  NewMedicalApp
//
//
//

#import "TestDALC.h"

@implementation TestDALC


+ (Test *)Agregar:(TestBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Test  *ObjDALC = [NSEntityDescription insertNewObjectForEntityForName:@"Test" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [ObjDALC setAddedByUser:ObjBE.addedByUser];
    [ObjDALC setDefault1:ObjBE.default1];
    [ObjDALC setDefault2:ObjBE.default2];
    [ObjDALC setGender:ObjBE.gender];
    [ObjDALC setLine11:ObjBE.line11];
    [ObjDALC setLine12:ObjBE.line12];
    [ObjDALC setLine13:ObjBE.line13];
    [ObjDALC setLine21:ObjBE.line21];
    [ObjDALC setLine22:ObjBE.line22];
    [ObjDALC setLine23:ObjBE.line23];
    [ObjDALC setRange1:ObjBE.range1];
    [ObjDALC setRange2:ObjBE.range2];
    [ObjDALC setTestID:ObjBE.testID];
    [ObjDALC setTestName:ObjBE.testName];
    [ObjDALC setTestScheduleType:ObjBE.testScheduleType];
    [ObjDALC setUnit1:ObjBE.unit1];
    [ObjDALC setUnit2:ObjBE.unit2];
    
    if (ObjBE.testScheduleCustomBE)
        [ObjDALC setTestScheduleCustom:[TestCustomDALC Agregar:ObjBE.testScheduleCustomBE]];
    
    if (ObjBE.testScheduleIntervalBE)
        [ObjDALC setTestScheduleInterval:[TestIntervalDALC Agregar:ObjBE.testScheduleIntervalBE]];
    
    if (ObjBE.testScheduleTimeBE)
        [ObjDALC setTestScheduleTimeTake:[TestTimeDALC Agregar:ObjBE.testScheduleTimeBE]];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO AGREGAR LA MEDICINA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (NSMutableArray *)Listar{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:[appDelegate managedObjectContext]];
	[fetchRequest setEntity:entity];
    
    NSMutableArray *array = [[[NSMutableArray alloc] initWithArray:[appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error]] autorelease];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"testName" ascending:YES] autorelease];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return array;
}

+ (NSMutableArray *)ListarTestAgregados{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:[appDelegate managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addedByUser == %@ ",[NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
	[fetchRequest setEntity:entity];
    
    NSArray *array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *arrayNoti = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"testName" ascending:YES] autorelease];
    [arrayNoti sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return arrayNoti;
}


+ (BOOL)Eliminar:(Test *)aTest{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[appDelegate managedObjectContext] deleteObject:aTest];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO BORRAR EL TEST: %@", [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}


+ (Test *)ObtenerTestPorTestID:(NSNumber *)testID{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * moc = [appDelegate managedObjectContext];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:moc];
    NSFetchRequest * request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"testID == %@",testID];
    [request setPredicate:predicate];
    NSArray *arrayMed = [moc executeFetchRequest:request error:nil];
    if ([arrayMed count] == 0) {
        return nil;
    }
    
    return [arrayMed objectAtIndex:0];
    
}


+ (Test *)Actualizar:(Test *)ObjDALC conDatosDe:(TestBE *)ObjBE{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [ObjDALC setAddedByUser:ObjBE.addedByUser];
    [ObjDALC setDefault1:ObjBE.default1];
    [ObjDALC setDefault2:ObjBE.default2];
    [ObjDALC setGender:ObjBE.gender];
    [ObjDALC setLine11:ObjBE.line11];
    [ObjDALC setLine12:ObjBE.line12];
    [ObjDALC setLine13:ObjBE.line13];
    [ObjDALC setLine21:ObjBE.line21];
    [ObjDALC setLine22:ObjBE.line22];
    [ObjDALC setLine23:ObjBE.line23];
    [ObjDALC setRange1:ObjBE.range1];
    [ObjDALC setRange2:ObjBE.range2];
    [ObjDALC setTestID:ObjBE.testID];
    [ObjDALC setTestName:ObjBE.testName];
    [ObjDALC setTestScheduleType:ObjBE.testScheduleType];
    [ObjDALC setUnit1:ObjBE.unit1];
    [ObjDALC setUnit2:ObjBE.unit2];
    
    [TestTimeDALC Eliminar:ObjDALC.testScheduleTimeTake];
    [TestIntervalDALC Eliminar:ObjDALC.testScheduleInterval];
    [TestCustomDALC Eliminar:ObjDALC.testScheduleCustom];
    
    
    if (ObjBE.testScheduleCustomBE)
        [ObjDALC setTestScheduleCustom:[TestCustomDALC Agregar:ObjBE.testScheduleCustomBE]];
    
    if (ObjBE.testScheduleIntervalBE)
        [ObjDALC setTestScheduleInterval:[TestIntervalDALC Agregar:ObjBE.testScheduleIntervalBE]];
    
    if (ObjBE.testScheduleTimeBE)
        [ObjDALC setTestScheduleTimeTake:[TestTimeDALC Agregar:ObjBE.testScheduleTimeBE]];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO ACTUALIZAR LA MEDICINA: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}


+ (Test *)Actualizar:(Test *)ObjDALC{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSError *error;
    
    if (![[appDelegate managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO ACTUALIZAR EL TEST: %@", [error localizedDescription]);
        return nil;
    }
    
    return ObjDALC;
}



@end
