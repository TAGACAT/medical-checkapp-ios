//
//  TestHistoryGraficaView.h
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "Test.h"

@interface TestHistoryGraficaView : CPTGraphHostingView <CPTPlotDataSource>{
    
    CPTXYGraph *graph;    
    NSMutableArray *array;
    
    Test *objTest;
}

@property (readwrite, retain) Test *objTest;
@property (readwrite, retain) NSMutableArray *array;

-(void)SetearGrafico;

@end
