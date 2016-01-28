//
//  AppDelegate.m
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import "AppDelegate.h"
#import "NSHTTPCookieStorage+Additional.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] load];

    return YES;
}

// this 3 methods needs to save/restore cookies, because they are not saves on the next launch the app and
// if app in background mode
- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] load];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] save];
}


@end
