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
		self.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
	
		self.labels = [NSMutableArray array];
		self.leftEdgeConstraints = [NSMutableArray array];
		
		//defaults
		self.numberOfLabels = 7;
		self.minimumLeftEdge = 30;
		self.maximumAdditionalOffset = 320;
		
		[self reloadLabels];
    }
    return self;
}

- (void)reloadLabels
{
	//remove the existing labels - this also removes the constraints from the view
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
		label.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		label.text = @"Label";
		label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
		label.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
		[self addSubview:label];
		
		//vertical layout
		[self addConstraint:[NSLayoutConstraint constraintWithItem:label
														 attribute:NSLayoutAttributeTop
														 relatedBy:NSLayoutRelationEqual
															toItem:previousLabel ? previousLabel : self
														 attribute:previousLabel ? NSLayoutAttributeBottom : NSLayoutAttributeTop
														multiplier:1
														  constant:40]];
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
