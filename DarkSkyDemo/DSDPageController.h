//
//  DSDPageController.h
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSDPageView;

@interface DSDPageController : UIViewController

@property DSDPageView *pageView;
- (void)updateViewForScrollFactor:(CGFloat)scrollFactor;

@end
