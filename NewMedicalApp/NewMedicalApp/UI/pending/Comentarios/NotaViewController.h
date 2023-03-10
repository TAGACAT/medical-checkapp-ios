//
//  NotaViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentBE.h"

@interface NotaViewController : UIViewController{
    
    CommentBE *objComent;
    IBOutlet UITextView *txtNota;
}

@property (readwrite, retain) CommentBE *objComent;

@end
