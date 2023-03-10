//
//  DidYouKnow.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DidYouKnow : NSObject {
    
    NSNumber *_identifier;
    NSString *_content;
    
}

@property (nonatomic,retain)  NSNumber *identifier;
@property (nonatomic,retain)  NSString *content;

@end
