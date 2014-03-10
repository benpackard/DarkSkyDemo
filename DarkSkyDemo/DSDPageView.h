//
//  DSDPageView.h
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSDPageView : UIView

@property NSInteger numberOfLabels, minimumLeftEdge, maximumAdditionalOffset;

- (void)setLabelsAlpha:(CGFloat)alpha;
- (void)setLabelsLeftEdgeDistanceFactor:(CGFloat)distanceFactor;

@end
