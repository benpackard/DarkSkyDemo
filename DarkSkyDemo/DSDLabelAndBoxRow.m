//
//  DSDLabelAndBoxRow.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/10/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDLabelAndBoxRow.h"

@implementation DSDLabelAndBoxRow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.label = [[UILabel alloc] init];
		self.label.translatesAutoresizingMaskIntoConstraints = NO;
		self.label.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:231.0/255.0 alpha:1.0];
		self.label.text = @"Label";
		self.label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
		self.label.textColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
		[self addSubview:self.label];
		
		self.box = [[UIView alloc] init];
		self.box.translatesAutoresizingMaskIntoConstraints = NO;
		self.box.backgroundColor = [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.0];
		self.box.layer.cornerRadius = 8.0;
		[self addSubview:self.box];
		
		NSDictionary *views = @{@"label":self.label, @"box":self.box};
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[box]-4-|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[label]" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[box(==50)]|" options:0 metrics:nil views:views]];
    }
    return self;
}

@end
