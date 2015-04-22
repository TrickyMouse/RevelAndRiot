    //
//  DetailViewController_iPad.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController_iPad.h"
#import "NewsViewController_iPad.h"
#import "AppDelegate_iPad.h";
#import <QuartzCore/QuartzCore.h>


@implementation DetailViewController_iPad

@synthesize contentString;
@synthesize titleString;
@synthesize contentView;
@synthesize newsViewController;

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
- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW STARTED LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW DID FINISH LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
	
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 768, 1004);
	// NSLog(@"self.view=%@", self.view);
	
	AppDelegate_iPad *appDelegate = (AppDelegate_iPad *)[[UIApplication sharedApplication] delegate];
	//rootViewDelegate = (RootViewController *)[[UIApplication sharedApplication] delegate];
	self.contentString = appDelegate.content;
	self.titleString = appDelegate.Title;
	//NSLog(@"%@",content);
	NSString *styledString = [[NSString alloc] initWithFormat:@"<h3>%@</h3>%@", titleString, contentString];
	
	NSString *webContent = [[NSString alloc]initWithString:styledString];
	//NSLog(@"%@",webContent);
	NSURL *url = [[NSURL alloc]initWithString:@"http://revelandriot.com/"];
	[contentView loadHTMLString:webContent baseURL:url];
	[url release];
	[styledString release];
	[webContent release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (IBAction) backButtonPressed:(id)sender {
	NSLog(@"BACK BUTTON");
	
	if (self.newsViewController == nil) {
		NewsViewController_iPad *newsView = [[NewsViewController_iPad alloc] initWithNibName:@"NewsViewController_iPad" bundle:[NSBundle mainBundle]];
		self.newsViewController = newsView;
		[newsView release];
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
		[animation setSubtype:kCATransitionFromRight];
	} else {*/
		[animation setSubtype:kCATransitionFromLeft];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
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
