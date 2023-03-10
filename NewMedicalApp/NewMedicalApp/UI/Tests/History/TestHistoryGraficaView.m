//
//  TestHistoryGraficaView.m
//  MedicalCheckApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestHistoryGraficaView.h"
#import "OSP_DateManager.h"


@implementation TestHistoryGraficaView
@synthesize array;
@synthesize objTest;

-(float)CalcularValorMaximoDelArray{
    
    if ([array count] == 0) {
        return 0;
    }
    
    NSMutableArray *arrayAux = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    NSSortDescriptor *sortByDate = [[[NSSortDescriptor alloc] initWithKey:@"y" ascending:YES] autorelease];
    [arrayAux sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return [[[arrayAux objectAtIndex:[arrayAux count] -1 ] objectForKey:@"y"] floatValue];
}


- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index{
    
    CPTTextLayer *newLayer = nil;
    
    if ( [(NSString *)plot.identifier isEqualToString:@"Blue Plot"]){
    
        static CPTMutableTextStyle *whiteText = nil;
        
        if ( !whiteText )
        {
            whiteText = [[CPTMutableTextStyle alloc] init];
            whiteText.color = [CPTColor blackColor];
        }
        
        NSString *str = [NSString stringWithFormat:@"%@ \n(%.2f)",[OSP_DateManager CambiaFecha:[[array objectAtIndex:index] objectForKey:@"fecha"] AlFormato:@"MMM dd yyyy"],[[[array objectAtIndex:index] valueForKey:@"y"] floatValue] ];
        
        newLayer = [[[CPTTextLayer alloc] initWithText:str style:whiteText] autorelease];
    }

    return newLayer;
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return [array count];
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
	NSNumber *num = [[array objectAtIndex:index] valueForKey:key];

    if ( [(NSString *)plot.identifier isEqualToString:@"VerdePlot_1"]){
        
        if ( fieldEnum == CPTScatterPlotFieldY ) {
			num = objTest.line11;
		}
    }else if ( [(NSString *)plot.identifier isEqualToString:@"VerdePlot_2"]){
        
        if ( fieldEnum == CPTScatterPlotFieldY ) {
			num = objTest.line12;
		}
    }

	return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods


-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
	static CPTTextStyle *positiveStyle = nil;
    
	NSNumberFormatter *formatter = axis.labelFormatter;
	CGFloat labelOffset			 = axis.labelOffset;
    
	NSMutableSet *newLabels = [NSMutableSet set];
    
	for ( NSDecimalNumber *tickLocation in locations ) {
		CPTTextStyle *theLabelTextStyle;
        
        if ( !positiveStyle ) {
            CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
            newStyle.color = [CPTColor blackColor];
            positiveStyle  = newStyle;
        }
        theLabelTextStyle = positiveStyle;
        
		NSString *labelString		= [formatter stringForObjectValue:tickLocation];
		CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        
		CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
		newLabel.tickLocation = tickLocation.decimalValue;
		newLabel.offset		  = labelOffset;
        
		[newLabels addObject:newLabel];
        
		[newLabel release];
		[newLabelLayer release];
	}
    
	axis.axisLabels = newLabels;
    
	return NO;
}

#pragma mark inicio


-(void)SetearGrafico{
    
    [graph release];

    // Create graph from theme
	graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
	[graph applyTheme:theme];
	CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self;
	hostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
	hostingView.hostedGraph		= graph;
    
	graph.paddingLeft	= 0.0;
	graph.paddingTop	= 0.0;
	graph.paddingRight	= 0.0;
	graph.paddingBottom = 0.0;
    
	// Setup plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
	plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.5) length:CPTDecimalFromFloat(4)];
	plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat([objTest.line11 floatValue]-[objTest.line11 floatValue]*0.09) length:CPTDecimalFromFloat([objTest.line12 floatValue] - [objTest.line11 floatValue] + [objTest.line11 floatValue]*0.1)];
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
	x.majorIntervalLength		  = CPTDecimalFromString(@"10");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.minorTicksPerInterval		  = 9;

	CPTXYAxis *y = axisSet.yAxis;
	y.majorIntervalLength		  = CPTDecimalFromString(@"25");
	y.minorTicksPerInterval		  = 0;
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	y.delegate			   = self;
    
	///linea------------------
    
    CPTScatterPlot *linea1  = [[[CPTScatterPlot alloc] init] autorelease];
	CPTMutableLineStyle *lineStyle1 = [CPTMutableLineStyle lineStyle];
	lineStyle1.miterLimit		= 1.0f;
	lineStyle1.lineWidth			= 3.0f;
	lineStyle1.lineColor			= [CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:0.8];
	linea1.dataLineStyle = lineStyle1;
	linea1.identifier	= @"VerdePlot_1";
	linea1.dataSource	= self;
	[graph addPlot:linea1];
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyleVerde1 = [CPTMutableLineStyle lineStyle];
	symbolLineStyleVerde1.lineColor = [CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:0.8];
	CPTPlotSymbol *plotSymbolVerde1 = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbolVerde1.fill			 = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:1]];
	plotSymbolVerde1.lineStyle	 = symbolLineStyleVerde1;
	plotSymbolVerde1.size			 = CGSizeMake(8.0, 8.0);
	linea1.plotSymbol = plotSymbolVerde1;
    
    //// linea---------------
    CPTScatterPlot *linea2  = [[[CPTScatterPlot alloc] init] autorelease];
	CPTMutableLineStyle *lineStyle2 = [CPTMutableLineStyle lineStyle];
	lineStyle2.miterLimit		= 1.0f;
	lineStyle2.lineWidth			= 3.0f;
	lineStyle2.lineColor			= [CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:0.8];
	linea2.dataLineStyle = lineStyle2;
	linea2.identifier	= @"VerdePlot_2";
	linea2.dataSource	= self;
	[graph addPlot:linea2];
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyleVerde2 = [CPTMutableLineStyle lineStyle];
	symbolLineStyleVerde2.lineColor = [CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:0.8];
	CPTPlotSymbol *plotSymbolVerde2 = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbolVerde2.fill			 = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0 green:0.75 blue:0 alpha:1]];
	plotSymbolVerde2.lineStyle	 = symbolLineStyleVerde2;
	plotSymbolVerde2.size			 = CGSizeMake(8.0, 8.0);
	linea2.plotSymbol = plotSymbolVerde2;
    
    /// linea--------------
    
    
    // Create a blue plot area
	CPTScatterPlot *boundLinePlot  = [[[CPTScatterPlot alloc] init] autorelease];
	CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
	lineStyle.miterLimit		= 1.0f;
	lineStyle.lineWidth			= 3.0f;
	lineStyle.lineColor			= [CPTColor colorWithComponentRed:0.75 green:0 blue:0 alpha:0.8];
	boundLinePlot.dataLineStyle = lineStyle;
	boundLinePlot.identifier	= @"Blue Plot";
	boundLinePlot.dataSource	= self;
	[graph addPlot:boundLinePlot];
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor colorWithComponentRed:0.75 green:0 blue:0 alpha:0.8];
	CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill			 = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:0.75 green:0 blue:0 alpha:1]];
	plotSymbol.lineStyle	 = symbolLineStyle;
	plotSymbol.size			 = CGSizeMake(8.0, 8.0);
	boundLinePlot.plotSymbol = plotSymbol;
    
	// Add some initial data
//	NSUInteger i;
//	for ( i = 0; i < 40; i++ ) {
//		id x = [NSNumber numberWithFloat:10*i];
//		id y = [NSNumber numberWithFloat:arc4random()%80];
//		[array addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
//	}

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    graph = [[CPTXYGraph alloc] init];
    [self SetearGrafico];
}

-(void)dealloc{
    
    [objTest release];
    [graph release];
    [array release];
    [super dealloc];
}



@end
