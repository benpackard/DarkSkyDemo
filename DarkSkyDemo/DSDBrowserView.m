//
//  DSDBrowserView.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDBrowserView.h"

@interface DSDBrowserView ()

@end

@implementation DSDBrowserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		
		UILabel *titleLabel = [[UILabel alloc] init];
		titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		titleLabel.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		titleLabel.text = @"Dark Sky Demo by Ben Packard";
		titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
		titleLabel.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
		[self addSubview:titleLabel];
		
		self.scrollView = [[UIScrollView alloc] init];
		self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
		self.scrollView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		self.scrollView.pagingEnabled = YES;
		self.scrollView.showsHorizontalScrollIndicator = NO;
		self.scrollView.alwaysBounceHorizontal = YES;
		[self addSubview:self.scrollView];
		
		self.contentView = [[UIView alloc] init];
		self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.scrollView addSubview:self.contentView];
		
		self.pageControl = [[UIPageControl alloc] init];
		self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
		self.pageControl.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:0.5];
		self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
		self.pageControl.enabled = NO; //touch events for page control are not implemented
		[self addSubview:self.pageControl];
	
		//scrollview and page control layout
		NSDictionary *views = @{@"title":titleLabel, @"scroll":self.scrollView, @"content":self.contentView, @"pager":self.pageControl};
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[title][scroll][pager(==20)]|" options:0 metrics:nil views:views]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
														 attribute:NSLayoutAttributeCenterX
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeCenterX
														multiplier:1
														  constant:0]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scroll]|" options:0 metrics:nil views:views]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
														 attribute:NSLayoutAttributeCenterX
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeCenterX
														multiplier:1
														  constant:0]];

		//content view layout - note that the controller must set the content view's width
		[self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[content]|" options:0 metrics:nil views:views]];
		[self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[content]|" options:0 metrics:nil views:views]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:self.scrollView
														 attribute:NSLayoutAttributeHeight
														multiplier:1
														  constant:0]];
    }
    return self;
}

@end
