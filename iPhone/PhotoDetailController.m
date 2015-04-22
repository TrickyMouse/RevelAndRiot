//
//  PhotoDetailController.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoDetailController.h"
#import "PhotoViewController.h"
#import "AppDelegate_iPhone.h"
#import <QuartzCore/QuartzCore.h>

@implementation PhotoDetailController

@synthesize photoViewController;
@synthesize appDelegate;


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
	
	if (self.photoViewController == nil) {
		PhotoViewController *newsView = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:[NSBundle mainBundle]];
		self.photoViewController = newsView;
		[newsView release];
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
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}

- (IBAction) closeButton:(id)sender {
	activityIndicator.hidden = YES;
	loading.hidden = YES;
	imageView.hidden = YES;
	closeButton.hidden = YES;
	imageBackgroundButton.hidden = YES;
	xImage.hidden = YES;
	
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	//CAPTURE USER LINK-CLICK.
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		activityIndicator.hidden = NO;
		loading.hidden = NO;
		[activityIndicator startAnimating];
		imageView.hidden = NO;
		closeButton.hidden = NO;
		imageBackgroundButton.hidden = NO;
		xImage.hidden = NO;
		NSURL *URL = [request URL];
		NSLog(@"url is: %@", URL);
		NSData *imageData = [NSData dataWithContentsOfURL:URL];
		UIImage *image = [UIImage imageWithData:imageData];
		[imageView setImage:image];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		return NO;
	}	
	return YES;   
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW STARTED LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	activityIndicator.hidden = NO;
	loading.hidden = NO;
	[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"WEBVIEW DID FINISH LOAD");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	activityIndicator.hidden = YES;
	loading.hidden = YES;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	imageView.hidden = YES;
	closeButton.hidden = YES;
	imageBackgroundButton.hidden = YES;
	xImage.hidden = YES;
	activityIndicator.hidden = YES;
	loading.hidden = YES;
	
	NSLog(@"self.view=%@", self.view);
	
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 320, 460);
	// NSLog(@"self.view=%@", self.view);
	appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	NSMutableString *htmlString = [[NSMutableString alloc] init];
	[htmlString appendString:@"<html><head></head><body><div class=\"photos\""];
	[htmlString appendString:@"<style>.photos {margin-left:5px;} img {max-width:88px!important; float:left!important;padding:2px!important;margin:2px!important;border:1px solid gray!important;}</style>"];
	[htmlString appendString:appDelegate.html];
	[htmlString appendString:@"</div></body>"];
	appDelegate.html = htmlString;
	[htmlString release];
	NSLog(@"%@",appDelegate.html);
	[webView loadHTMLString:appDelegate.html baseURL:nil];
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
