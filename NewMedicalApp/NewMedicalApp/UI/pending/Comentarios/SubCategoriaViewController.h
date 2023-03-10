//
//  SubCategoriaViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "ComentariosViewController.h"

@interface SubCategoriaViewController : UIViewController<UITableViewDataSource , UITableViewDelegate, ASIHTTPRequestDelegate>{
    
    IBOutlet UITableView *myTable;
    NSMutableArray *arrayTable;
    
    ASIFormDataRequest *aRequest;
    
    MBProgressHUD *hud;
    
    NSString *set;
    
    NSMutableDictionary *diccionarioValores;
}

@property (readwrite, retain) NSMutableDictionary *diccionarioValores;
@property (readwrite, retain) NSString *set;
@property (readwrite , retain) NSMutableArray *arrayTable;
@property(nonatomic,retain) ASIFormDataRequest *aRequest;


@end
