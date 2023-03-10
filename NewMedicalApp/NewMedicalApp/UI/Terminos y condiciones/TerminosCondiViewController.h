//
//  TerminosCondiViewController.h
//  MedicalApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TerminosCondiViewController : UIViewController{
    
    IBOutlet UISwitch *mySwitch;
    IBOutlet UIButton *btnAceptar;
}

- (IBAction)onChangeState:(id)sender;
- (IBAction)ClicContinuar:(id)sender;


@end
