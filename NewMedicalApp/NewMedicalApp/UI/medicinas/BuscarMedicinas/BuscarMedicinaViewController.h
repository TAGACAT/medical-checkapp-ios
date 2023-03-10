//
//  BuscarMedicinaViewController.h
//  NewMedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MedicinaBE.h"
#import "MBProgressHUD.h"
#import "NuevaMedicinaViewController.h"
#import "PackageSizeViewController.h"
#import "HeaderDrugBE.h"
#import "HeaderDrugDALC.h"

#define CHARACTERS          @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzñÑ"
#define CHARACTERS_NUMBERS  [CHARACTERS stringByAppendingString:@"1234567890"]


@interface BuscarMedicinaViewController : UIViewController <ASIHTTPRequestDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>{
    
    ASIFormDataRequest *arequest;
    int Pagina;
    
    MBProgressHUD *hud;
    
    IBOutlet UILabel *lblRestantes;
    IBOutlet UISearchBar *mySearchBar;
    IBOutlet UITableView *myTableView;
    
    BOOL Cargando;
    
    MedicinaBE *objMedicinaBE;
}

@property (readwrite, retain) NSMutableArray *ArrayMedicamentos;
@property (nonatomic, retain) ASIFormDataRequest *arequest;





@end
