//
//  DSDBrowserController.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDBrowserController.h"

//views
#import "DSDBrowserView.h"
#import "DSDPageView.h"

//controllers
#import "DSDPageController.h"

@interface DSDBrowserController ()

@property DSDBrowserView *browserView;
@property NSMutableArray *pageControllers;

@end

@implementation DSDBrowserController

static NSInteger const kNumberOfPages = 3; //could move this to a property

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		self.pageControllers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.browserView = [[DSDBrowserView alloc] init];
	self.browserView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.browserView];
	NSDictionary *views = @{@"browser":self.browserView};
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[browser]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[browser]|" options:0 metrics:nil views:views]];

	//add three pages (could easily be generalized)
	self.browserView.pageControl.numberOfPages = kNumberOfPages;
	[self.browserView addConstraint:[NSLayoutConstraint constraintWithItem:self.browserView.contentView
													 attribute:NSLayoutAttributeWidth
													 relatedBy:NSLayoutRelationEqual
														toItem:self.browserView
													 attribute:NSLayoutAttributeWidth
													multiplier:kNumberOfPages
													  constant:0]];
	
	//monitor scrolling
	self.browserView.scrollView.delegate = self;
	
	//load pages
	[self reloadPages];
}

- (void)reloadPages
{
	//remove the existing page controllers and views
	for (DSDPageController *pageController in self.pageControllers)
	{
		[pageController willMoveToParentViewController:nil];
		[pageController.view removeFromSuperview];
		[pageController removeFromParentViewController];
	}
	[self.pageControllers removeAllObjects];
	
	//add each page controller and its view
	for (NSInteger i = 0; i < kNumberOfPages; i++)
	{
		//create the team controller
		DSDPageController *pageController = [[DSDPageController alloc] initWithNibName:nil bundle:nil];
		[self.pageControllers addObject:pageController];
		[self addChildViewController:pageController];
		
		//add its view - align the view depending on its index
		pageController.view.translatesAutoresizingMaskIntoConstraints = NO;
		pageController.pageView.numberOfLabels = i == 0 ? 0 : 7; //no labels on the first page for demo purposes
		[self.browserView.contentView addSubview:pageController.view];
		NSDictionary *views = @{@"page":pageController.view};
		[self.browserView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[page]|" options:0 metrics:nil views:views]];
		[self.browserView.contentView addConstraint:[NSLayoutConstraint constraintWithItem:pageController.view
																				 attribute:NSLayoutAttributeLeft
																				 relatedBy:NSLayoutRelationEqual
																					toItem:self.browserView.contentView
																				 attribute:NSLayoutAttributeLeft
																				multiplier:1
																				  constant:(float)i * self.view.bounds.size.width]];
		[self.browserView addConstraint:[NSLayoutConstraint constraintWithItem:pageController.view
																	 attribute:NSLayoutAttributeWidth
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.browserView
																	 attribute:NSLayoutAttributeWidth
																	multiplier:1
																	  constant:0]];
		[pageController didMoveToParentViewController:self];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	//update the page control on scrolling
	CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.browserView.pageControl.currentPage = page;
	
	//update each page depending on the distance between itself and the scrollview
	CGFloat contentOffset = self.browserView.scrollView.contentOffset.x;
	for (NSInteger i = 0; i < self.pageControllers.count; i++)
	{
		CGFloat viewOffset = i * pageWidth;
		
		CGFloat distance = viewOffset - contentOffset;
		CGFloat cappedDistance = MIN(distance, pageWidth);
		cappedDistance = MAX(cappedDistance, -pageWidth);
		CGFloat scrollFactor = (cappedDistance / pageWidth);
		DSDPageController *pageController = [self.pageControllers objectAtIndex:i];
		[pageController updateViewForScrollFactor:scrollFactor];
    }
}

@end