//
//  DSDPageView.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDPageView.h"

//views
#import "DSDLabelAndBoxRow.h"

@interface DSDPageView ()

@property NSMutableArray *labelViews, *leftEdgeConstraints;

@end

@implementation DSDPageView

@synthesize numberOfLabels = _numberOfLabels;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
	
		self.labelViews = [NSMutableArray array];
		self.leftEdgeConstraints = [NSMutableArray array];
		
		//defaults
		self.minimumLeftEdge = 30;
		self.maximumAdditionalOffset = 400; //seems to be close to the dark sky value
		self.numberOfLabels = 7;
    }
    return self;
}

- (NSInteger)numberOfLabels
{
	return _numberOfLabels;
}

- (void)setNumberOfLabels:(NSInteger)numberOfLabels
{
	_numberOfLabels = numberOfLabels;
	[self reloadLabels];
}

- (void)reloadLabels
{
	//remove the existing labels - this also removes the constraints from the view
	for (DSDLabelAndBoxRow *labelView in self.labelViews)
	{
		[labelView removeFromSuperview];
	}
	[self.labelViews removeAllObjects];
	
	//empty the constraints array
	[self.leftEdgeConstraints removeAllObjects];
		
	//add the labels
	DSDLabelAndBoxRow *previousLabel = nil;
	for (NSInteger i = 0; i < self.numberOfLabels; i++)
	{
		DSDLabelAndBoxRow *labelView = [[DSDLabelAndBoxRow alloc] init];
		[self.labelViews addObject:labelView];
		labelView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:labelView];
		
		//vertical layout
		[self addConstraint:[NSLayoutConstraint constraintWithItem:labelView
														 attribute:NSLayoutAttributeTop
														 relatedBy:NSLayoutRelationEqual
															toItem:previousLabel ? previousLabel : self
														 attribute:previousLabel ? NSLayoutAttributeBottom : NSLayoutAttributeTop
														multiplier:1
														  constant:35]];
		previousLabel = labelView;
		
		//width
		[self addConstraint:[NSLayoutConstraint constraintWithItem:labelView
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1
														  constant:-2 * self.minimumLeftEdge]];
		
		//add and store the left-edge constraint
		NSLayoutConstraint *leftEdgeConstraint = [NSLayoutConstraint constraintWithItem:labelView
																			  attribute:NSLayoutAttributeLeft
																			  relatedBy:NSLayoutRelationEqual
																				 toItem:self
																			  attribute:NSLayoutAttributeLeft
																			 multiplier:1
																			   constant:self.minimumLeftEdge];
		[self.leftEdgeConstraints addObject:leftEdgeConstraint];
		[self addConstraint:leftEdgeConstraint];
	}
}

- (void)setLabelsAlpha:(CGFloat)alpha
{
	//fade all labels as they move out of view
	for (DSDLabelAndBoxRow *labelView in self.labelViews)
	{
		labelView.alpha = alpha;
	}
}

- (void)setLabelsLeftEdgeDistanceFactor:(CGFloat)distanceFactor
{
	//the factor is between -1 and 1 where 0 means the label should be in its true 'home' position (set via self.minimumLeftEdge)
	//self.mamaximumAdditionalOffset determines how far the bottom-most label should travel - other labels' travel distances are proportional
	for (NSInteger i = 0; i < self.leftEdgeConstraints.count; i++)
	{
		NSLayoutConstraint *constraint = [self.leftEdgeConstraints objectAtIndex:i];
		CGFloat proportionalTravelDistance = (CGFloat)i / self.leftEdgeConstraints.count;
		constraint.constant = self.minimumLeftEdge + (distanceFactor * self.maximumAdditionalOffset * proportionalTravelDistance);
	}
}

@end
