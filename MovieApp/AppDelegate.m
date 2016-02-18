//
//  AppDelegate.m
//  MovieApp
//
//  Created by XtronLabs.inc on 11/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlus/GooglePlus.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    static NSString * const kClientId = @"554868509290-o65i33mi6v4q2ctjv25gfq0he8h8dtur.apps.googleusercontent.com";
    [GPPSignIn sharedInstance].clientID = kClientId;

    [[Twitter sharedInstance] startWithConsumerKey:@"qvGx9oRa6ds4qOt4S3pycc6JB" consumerSecret:@"i1OGT6zidMTZx930iGBKUO8vezIYY58pLeHpf2h9JgAH7CDwtq"];
    [Fabric with:@[[Twitter sharedInstance]]];
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [FBSDKAppEvents activateApp];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    

}

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
    
    
    if([[url scheme] caseInsensitiveCompare:@"fb1655495941349109"] == NSOrderedSame)
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    } else {

    
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }
    
    
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"Opened by handling url: %@", [url absoluteString]);
    
    return YES;
}

@end
