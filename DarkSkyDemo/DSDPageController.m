//
//  DSDPageController.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDPageController.h"

//views
#import "DSDPageView.h"

@interface DSDPageController ()

@property DSDPageView *pageView;

@end

@implementation DSDPageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//add the page view
	self.pageView = [[DSDPageView alloc] init];
	self.pageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.pageView];
	NSDictionary *views = @{@"page":self.pageView};
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[page]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[page]|" options:0 metrics:nil views:views]];
	
	//set the number of labels and the min/max edge and reload
	self.pageView.numberOfLabels = 7;
	self.pageView.minimumLeftEdge = 20;
	self.pageView.maximumAdditionalOffset = 320; //approximates the value used by Dark Sky
	[self.pageView reloadLabels];
}

- (void)updateViewForScrollFactor:(CGFloat)scrollFactor
{
	[self.pageView setLabelsAlpha:1 - fabs(scrollFactor)];
	[self.pageView setLabelsLeftEdgeDistanceFactor:scrollFactor];
}

@end
