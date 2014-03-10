//
//  DSDAppDelegate.m
//  DarkSkyDemo
//
//  Created by Ben Packard on 3/9/14.
//  Copyright (c) 2014 Made in Bletchley. All rights reserved.
//

#import "DSDAppDelegate.h"

//controllers
#import "DSDBrowserController.h"

@implementation DSDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	DSDBrowserController *controller = [[DSDBrowserController alloc] initWithNibName:nil bundle:nil];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = controller;
	[self.window makeKeyAndVisible];

    return YES;
}

@end
