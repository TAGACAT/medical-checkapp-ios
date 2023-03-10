//
//  CategoriasViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "SubCategoriaViewController.h"
#import "NotaViewController.h"
#import "CommentBE.h"

@interface CategoriasViewController : UIViewController <UITableViewDataSource , UITableViewDelegate, ASIHTTPRequestDelegate>{
    
    IBOutlet UITableView *myTable;
    NSMutableArray *arrayTable;
    
    ASIFormDataRequest *aRequest;
    
    MBProgressHUD *hud;
    
    NSMutableArray *arrayComentarios;
    CommentBE *comentNota;
    
    NSString *nombreNotificacion;
    NSMutableDictionary *diccionarioValores;
}

@property (readwrite, retain) NSString *nombreNotificacion;
@property (readwrite , retain) NSMutableArray *arrayTable;
@property(nonatomic,retain) ASIFormDataRequest *aRequest;


@end
