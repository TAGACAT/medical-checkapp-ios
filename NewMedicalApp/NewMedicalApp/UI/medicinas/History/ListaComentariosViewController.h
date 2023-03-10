//
//  ListaComentariosViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface ListaComentariosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *arrayTable;
}

@property (readwrite, retain) NSMutableArray *arrayTable;

@end
