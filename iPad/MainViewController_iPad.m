    //
//  MainViewController_iPad.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController_iPad.h"
#import <QuartzCore/QuartzCore.h>


@implementation MainViewController_iPad

@synthesize newsViewController;
@synthesize photoViewController;
@synthesize resourceViewController;
@synthesize aboutViewController;
@synthesize contactViewController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */
- (IBAction) newsButtonPressed:(id)sender {
	NSLog(@"NEWS BUTTON");
	
	if (self.newsViewController == nil) {
		NewsViewController_iPad *subView = [[NewsViewController_iPad alloc] initWithNibName:@"NewsViewController_iPad" bundle:[NSBundle mainBundle]];
		self.newsViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = newsViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromLeft];
	} else {*/
		[animation setSubtype:kCATransitionFromRight];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	
}

- (IBAction) photosButtonPressed:(id)sender {
	NSLog(@"PHOTOS BUTTON");
	
	if (self.photoViewController == nil) {
		PhotoViewController_iPad *photoView = [[PhotoViewController_iPad alloc] initWithNibName:@"PhotoViewController_iPad" bundle:[NSBundle mainBundle]];
		self.photoViewController = photoView;
		[photoView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = photoViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromLeft];
	} else {*/
		[animation setSubtype:kCATransitionFromRight];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	 
}

- (IBAction) resourcesButtonPressed:(id)sender {
	NSLog(@"RESOURCES BUTTON");
	
	if (self.resourceViewController == nil) {
		ResourceViewController_iPad *subView = [[ResourceViewController_iPad alloc] initWithNibName:@"ResourceViewController_iPad" bundle:[NSBundle mainBundle]];
		self.resourceViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = resourceViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromLeft];
	} else {*/
		[animation setSubtype:kCATransitionFromRight];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	 
}

- (IBAction) aboutButtonPressed:(id)sender {
	NSLog(@"ABOUT BUTTON");
	
	if (self.aboutViewController == nil) {
		AboutViewController_iPad *subView = [[AboutViewController_iPad alloc] initWithNibName:@"AboutViewController_iPad" bundle:[NSBundle mainBundle]];
		self.aboutViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = aboutViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromLeft];
	} else {*/
		[animation setSubtype:kCATransitionFromRight];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	 
}

- (IBAction) contactButtonPressed:(id)sender {
	NSLog(@"CONTACT BUTTON");
	
	if (self.contactViewController == nil) {
		ContactViewController_iPad *subView = [[ContactViewController_iPad alloc] initWithNibName:@"ContactViewController_iPad" bundle:[NSBundle mainBundle]];
		self.contactViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = contactViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromRight];
	} else if (UIInterfaceOrientationPortraitUpsideDown) {*/
	[animation setSubtype:kCATransitionFromRight];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	 
	
}

- (IBAction) shopButtonPressed:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.maplemusic.com/dept.asp?dept_id=3420"]];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"self.view=%@", self.view);
	
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 768, 1024);
	// NSLog(@"self.view=%@", self.view);
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
 }*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
