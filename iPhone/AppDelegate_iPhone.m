//
//  AppDelegate_iPhone.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "MainViewController.h"
#import "Reachability.h"

@implementation AppDelegate_iPhone

@synthesize window;
@synthesize mainViewController;
@synthesize content;
@synthesize Title;
@synthesize revelOn, merchPhotosDownloaded, mannequeerPhotosDownloaded, LGBTQPhotosDownloaded;
@synthesize html;
@synthesize merchPhotoHTML, mannequeerPhotoHTML, LGBTQPhotoHTML;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
		
    //appDelegate Booleans
	revelOn = YES;
	merchPhotosDownloaded = NO;
	mannequeerPhotosDownloaded = NO;
	LGBTQPhotosDownloaded = NO;
	
    // Override point for customization after application launch.
	if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
		NSLog(@"There is Internet access - proceed");
		// Add the view controller's view to the window and display.
	
	MainViewController *firstViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
	self.mainViewController = firstViewController;
	[firstViewController release];
	[window addSubview:[mainViewController view]];
    [self.window makeKeyAndVisible];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"No Internet Connection Found" 
							  message:@"Revel & Riot requires internet access to run.  Please check your Network Settings to continue" 
							  delegate:nil 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
	
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[mainViewController release];
	[Title release];

	[html release];
	[merchPhotoHTML release];
	[mannequeerPhotoHTML release];
	[LGBTQPhotoHTML release];
	
	[content release];
    [window release];
    [super dealloc];
}


@end
