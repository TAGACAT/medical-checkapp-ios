//
//  DidYouKnowDatasource.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DidYouKnowDatasource : NSObject {
    
    
    
}

- (void)openDatabase;
- (NSArray *)getDidYouKnows;

@end
