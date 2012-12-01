//
//  NoiteHojeAppDelegate.m
//  NHCalendarActivityDemo
//
//  Created by Otavio Cordeiro on 12/1/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "AppDelegate.h"

#import "DemoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[DemoViewController alloc] initWithNibName:@"NoiteHojeViewController"
                                                                    bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
