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
		self.backgroundColor = [UIColor greenColor];
		
		self.scrollView = [[UIScrollView alloc] init];
		self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
		self.scrollView.backgroundColor = [UIColor cyanColor];
		self.scrollView.pagingEnabled = YES;
		self.scrollView.showsHorizontalScrollIndicator = NO;
		self.scrollView.alwaysBounceHorizontal = YES;
		[self addSubview:self.scrollView];
		
		self.contentView = [[UIView alloc] init];
		self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
		self.contentView.backgroundColor = [UIColor blueColor];
		[self.scrollView addSubview:self.contentView];
		
		self.pageControl = [[UIPageControl alloc] init];
		self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
		self.pageControl.backgroundColor = [UIColor redColor];
		self.pageControl.enabled = NO; //touch events not implemented
		[self addSubview:self.pageControl];
	
		//scrollview and page control layout
		NSDictionary *views = @{@"scroll":self.scrollView, @"content":self.contentView, @"pager":self.pageControl};
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scroll][pager(==14)]|" options:0 metrics:nil views:views]];
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
