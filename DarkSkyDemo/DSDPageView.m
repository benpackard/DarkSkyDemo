//
//  DSDPageView.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDPageView.h"

@interface DSDPageView ()

@property NSMutableArray *labels, *leftEdgeConstraints;

@end

@implementation DSDPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor yellowColor];
	
		self.labels = [NSMutableArray array];
		self.leftEdgeConstraints = [NSMutableArray array];
		
		//defaults
		self.numberOfLabels = 7;
		self.minimumLeftEdge = 20;
		self.maximumAdditionalOffset = 320;
		
		[self reloadLabels];
    }
    return self;
}

- (void)reloadLabels
{
	//remove the existing labels - also removes the constraints from the view
	for (UILabel *label in self.labels)
	{
		[label removeFromSuperview];
	}
	[self.labels removeAllObjects];
	
	//empty the constraints array
	[self.leftEdgeConstraints removeAllObjects];
		
	//add the labels
	UILabel *previousLabel = nil;
	for (NSInteger i = 0; i < self.numberOfLabels; i++)
	{
		UILabel *label = [[UILabel alloc] init];
		[self.labels addObject:label];
		label.translatesAutoresizingMaskIntoConstraints = NO;
		label.backgroundColor = [UIColor whiteColor];
		label.text = @"Label";
		[self addSubview:label];
		
		//vertical layout
		if (previousLabel)
		{
			[self addConstraint:[NSLayoutConstraint constraintWithItem:label
															 attribute:NSLayoutAttributeTop
															 relatedBy:NSLayoutRelationEqual
																toItem:previousLabel
															 attribute:NSLayoutAttributeBottom
															multiplier:1
															  constant:40]];
		}
		else
		{
			[self addConstraint:[NSLayoutConstraint constraintWithItem:label
															 attribute:NSLayoutAttributeTop
															 relatedBy:NSLayoutRelationEqual
																toItem:self
															 attribute:NSLayoutAttributeTop
															multiplier:1
															  constant:100]];
		}
		previousLabel = label;
		
		//add and store the left-edge constraint
		NSLayoutConstraint *leftEdgeConstraint = [NSLayoutConstraint constraintWithItem:label
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
	for (UILabel *label in self.labels)
	{
		label.alpha = alpha;
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
