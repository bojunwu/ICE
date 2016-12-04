//
//  EmergencyAppDelegate.m
//  Emergency
//
//  Created by Bojun Wu on 4/21/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//

#import "EmergencyAppDelegate.h"

#import "HomeController.h"
@implementation EmergencyAppDelegate

-(void) applicationDidFinishLaunching:(UIApplication *) application {
    UIWindow *window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    //hide statusbar
    //  [[UIApplication sharedApplication] setStatusBarHidden:YES
    //                                           withAnimation:UIStatusBarAnimationFade];
    UINavigationController * nav =
    [[UINavigationController alloc] initWithRootViewController:[[HomeController alloc] init]];
    [window setRootViewController:nav];
    [window addSubview: nav.view];
    [window makeKeyAndVisible];
    NSLog(@"AppDelegate");


}



@end
