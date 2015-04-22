//
//  ResourceViewController.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResourceViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ResourceViewController

@synthesize mainViewController;

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

- (IBAction)menuButtonPressed:(id)sender {
	NSLog(@"MENU BUTTON PRESSED");
	
	if (self.mainViewController == nil) {
		MainViewController *subView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
		self.mainViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = mainViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW STARTED LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	activityIndicator.hidden = NO;
	loading.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW DID FINISH LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	loading.hidden = YES;
	activityIndicator.hidden = YES;
	[activityIndicator stopAnimating];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	//CAPTURE USER LINK-CLICK.
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		NSURL *URL = [request URL];
		NSLog(@"url is: %@", URL);
		
		[[UIApplication sharedApplication] openURL:URL];
		
		return NO;
	}	
	return YES;   
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"self.view=%@", self.view);
	[activityIndicator startAnimating];

	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 320, 460);
	// NSLog(@"self.view=%@", self.view);
	NSString *urlAddress = @"http://revelandriot.com/iphone-resources";
	
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
