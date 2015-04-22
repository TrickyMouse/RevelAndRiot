    //
//  PhotoViewController_iPad.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController_iPad.h"
#import "MainViewController_iPad.h"
#import "AppDelegate_iPad.h"
#import "PhotoDetailController_iPad.h"
#import <QuartzCore/QuartzCore.h>


@implementation PhotoViewController_iPad

@synthesize mainViewController;
@synthesize photoDetailController;
@synthesize appDelegate;

#pragma mark XML PARSER METHODS

- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	stories = [[NSMutableArray alloc] init];
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:YES];
    [rssParser setShouldReportNamespacePrefixes:YES];
    [rssParser setShouldResolveExternalEntities:YES];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
	NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
		//currentThumb = [[NSMutableString alloc] init];
		//currentThumb = [[NSMutableString alloc] initWithString:[attributeDict valueForKey:@"url"]];
	} else if ([elementName isEqualToString:@"thumbnail"]) {
		//NSLog(@"%@", [attributeDict valueForKey:@"url"]);
		currentThumb = [[NSMutableString alloc] initWithString:[attributeDict valueForKey:@"url"]];
		NSLog(@"%@", currentThumb);
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentThumb forKey:@"thumbnail"];
		[stories addObject:[[item copy] autorelease]];
		NSLog(@"adding title: %@", currentTitle);
		NSLog(@"adding link: %@", currentLink);
		NSLog(@"adding thumbnail: %@", currentThumb);
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"thumbnail"]) {
		[currentThumb appendString:string];
	} 
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
}

#pragma mark BUTTON METHODS

- (IBAction)menuButtonPressed:(id)sender {
	NSLog(@"MENU BUTTON PRESSED");
	
	if (self.mainViewController == nil) {
		MainViewController_iPad *newsView = [[MainViewController_iPad alloc] initWithNibName:@"MainViewController_iPad" bundle:[NSBundle mainBundle]];
		self.mainViewController = newsView;
		[newsView release];
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
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromRight];
	} else {*/
		[animation setSubtype:kCATransitionFromLeft];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}


- (IBAction)merchandisePressed:(id)sender {
	activityIndicator.hidden = NO;
	loading.hidden = NO;
	[activityIndicator startAnimating];
	[self performSelector:@selector(loadMerchPhoto:) withObject:nil afterDelay:0];
}

- (IBAction)loadMerchPhoto:(id) sender {
	
	NSLog(@"merchandise");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if (appDelegate.merchPhotosDownloaded == NO) {
		
		NSString *path = @"http://www.revelandriot.com/wp-content/plugins/nextgen-gallery/xml/media-rss.php?mode=gallery&show=1000";
		[self parseXMLFileAtURL:path];
		//NSLog(@"item: %@", stories);
		NSMutableString *imageFormat = [NSMutableString stringWithString:@""];
		
		int i;
		for (i = 0; i < stories.count; i++) {
			
			NSString *imageThumb = [[stories objectAtIndex:i] objectForKey:@"thumbnail"];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"	" withString:@""];
			
			NSString *imageURL = [[stories objectAtIndex:i] objectForKey:@"link"];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"	" withString:@""];
			NSString *htmlString = [[[NSString alloc] initWithFormat:@"<a href=\"%@\"><img src=\"%@\" width=\"90\" height=\"60\" /></a>", imageURL,imageThumb] autorelease];
			[imageFormat appendString:htmlString];
		}
		appDelegate.merchPhotoHTML = imageFormat;
		appDelegate.html = appDelegate.merchPhotoHTML;
		NSLog(@"%@",appDelegate.html);
		appDelegate.merchPhotosDownloaded = YES;
	} else {
		
		appDelegate.html = appDelegate.merchPhotoHTML;
	}
	if (self.photoDetailController == nil) {
		PhotoDetailController_iPad *photoView = [[PhotoDetailController_iPad alloc] initWithNibName:@"PhotoDetailController_iPad" bundle:[NSBundle mainBundle]];
		self.photoDetailController = photoView;
		[photoView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = photoDetailController.view; 
	
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

- (IBAction)mannequeersPressed:(id)sender {
	
	activityIndicator.hidden = NO;
	loading.hidden = NO;
	[activityIndicator startAnimating];
	[self performSelector:@selector(loadMannePhoto:) withObject:nil afterDelay:0];
}

- (IBAction)loadMannePhoto:(id) sender {
	NSLog(@"mannequeers");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if (appDelegate.mannequeerPhotosDownloaded == NO ){
		
		NSString *path = @"http://www.revelandriot.com/wp-content/plugins/nextgen-gallery/xml/media-rss.php?mode=album&aid=6&show=1000";
		[self parseXMLFileAtURL:path];
		//NSLog(@"item: %@", stories);
		NSMutableString *imageFormat = [NSMutableString stringWithString:@""];
		int i;
		for (i = 0; i < stories.count; i++) {
			
			NSString *imageThumb = [[stories objectAtIndex:i] objectForKey:@"thumbnail"];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"	" withString:@""];
			
			NSString *imageURL = [[stories objectAtIndex:i] objectForKey:@"link"];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"	" withString:@""];
			NSString *htmlString = [[[NSString alloc] initWithFormat:@"<a href=\"%@\"><img src=\"%@\" width=\"90\" height=\"60\" /></a>", imageURL,imageThumb] autorelease];
			[imageFormat appendString:htmlString];
		}
		appDelegate.mannequeerPhotoHTML = imageFormat;
		appDelegate.html = appDelegate.mannequeerPhotoHTML;
		//[imageFormat release];
		NSLog(@"%@",appDelegate.html);
		appDelegate.mannequeerPhotosDownloaded = YES;
	} else {
		appDelegate.html = appDelegate.mannequeerPhotoHTML;
	}
	
	if (self.photoDetailController == nil) {
		PhotoDetailController_iPad *photoView = [[PhotoDetailController_iPad alloc] initWithNibName:@"PhotoDetailController_iPad" bundle:[NSBundle mainBundle]];
		self.photoDetailController = photoView;
		[photoView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = photoDetailController.view; 
	
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

- (IBAction)LGBTQPressed:(id)sender {
	
	activityIndicator.hidden = NO;
	loading.hidden = NO;
	[activityIndicator startAnimating];
	[self performSelector:@selector(loadLGBTQPhoto:) withObject:nil afterDelay:0];
}

- (IBAction)loadLGBTQPhoto:(id) sender {
	NSLog(@"LGBTQ");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if (appDelegate.LGBTQPhotosDownloaded == NO) {
		
		NSString *path = @"http://www.revelandriot.com/wp-content/plugins/nextgen-gallery/xml/media-rss.php?mode=album&aid=5&show=1000";
		[self parseXMLFileAtURL:path];
		//NSLog(@"item: %@", stories);
		NSMutableString *imageFormat = [NSMutableString stringWithString:@""];
		int i;
		for (i = 0; i < stories.count; i++) {
			
			NSString *imageThumb = [[stories objectAtIndex:i] objectForKey:@"thumbnail"];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageThumb = [imageThumb stringByReplacingOccurrencesOfString:@"	" withString:@""];
			
			NSString *imageURL = [[stories objectAtIndex:i] objectForKey:@"link"];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			imageURL = [imageURL stringByReplacingOccurrencesOfString:@"	" withString:@""];
			NSString *htmlString = [[[NSString alloc] initWithFormat:@"<a href=\"%@\"><img src=\"%@\" width=\"90\" height=\"60\" /></a>", imageURL,imageThumb] autorelease];
			[imageFormat appendString:htmlString];
		}
		appDelegate.LGBTQPhotoHTML = imageFormat;
		appDelegate.html = appDelegate.LGBTQPhotoHTML;
		//[imageFormat release];
		NSLog(@"%@",appDelegate.html);
		appDelegate.LGBTQPhotosDownloaded = YES;
	} else {
		appDelegate.html = appDelegate.LGBTQPhotoHTML;
	}
	
	if (self.photoDetailController == nil) {
		PhotoDetailController_iPad *photoView = [[PhotoDetailController_iPad alloc] initWithNibName:@"PhotoDetailController_iPad" bundle:[NSBundle mainBundle]];
		self.photoDetailController = photoView;
		[photoView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = photoDetailController.view; 
	
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






#pragma mark viewDidLoad


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"self.view=%@", self.view);
	activityIndicator.hidden = YES;
	loading.hidden = YES;
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 768, 1004);
	// NSLog(@"self.view=%@", self.view);
	appDelegate = (AppDelegate_iPad *)[[UIApplication sharedApplication] delegate];
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
