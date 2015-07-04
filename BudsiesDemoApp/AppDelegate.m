//
//  AppDelegate.m
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];

    return YES;
}


@end
