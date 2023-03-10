//
//  DidYouKnowDatasource.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DidYouKnowDatasource.h"
#import "DidYouKnow.h"
#define DATABASE_NAME @"DidYouKnowDatabase.sqlite"

@implementation DidYouKnowDatasource

- (void)openDatabase {
    
    NSString *databasePath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    BOOL success = false;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];
	if(success) return;
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

- (NSArray *)getDidYouKnows {
    
    NSString *databasePath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    sqlite3 *database;
	NSMutableArray *didYouKnowArray = [[[NSMutableArray alloc] init] autorelease];
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		const char *sqlStatement = "SELECT * FROM DidYouKnow";
		sqlite3_stmt *compiledStatement;
        int result = sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
		if(result == SQLITE_OK) {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				int aIdentifier = (int)sqlite3_column_int(compiledStatement, 0);
				NSString *aContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                DidYouKnow *didYouKnow = [[DidYouKnow alloc] init]; 
                [didYouKnow setIdentifier:[NSNumber numberWithInt:aIdentifier]];
                [didYouKnow setContent:aContent];
                [didYouKnowArray addObject:didYouKnow];
				[didYouKnow release];
			}
		}
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    return didYouKnowArray;
    
}

- (void)dealloc {
    [super dealloc];
}

@end
