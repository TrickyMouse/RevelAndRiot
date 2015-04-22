    //
//  NewsViewController_iPad.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController_iPad.h"
#import "DetailViewController_iPad.h"
#import "AppDelegate_iPad.h"
#import <QuartzCore/QuartzCore.h>


@implementation NewsViewController_iPad

@synthesize mainViewController;
@synthesize detailViewController;
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

#pragma mark revelView tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [stories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellID = @"customCell";
	
	revelViewCell_iPad *cell = (revelViewCell_iPad *)[tableView dequeueReusableCellWithIdentifier:cellID];
	
	
	if (cell == nil) {
		//cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		NSLog(@"Cell created");
		
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"revelViewCell_iPad" owner:nil options:nil];
		
		for (id currentObject in nibObjects) {
			if([currentObject isKindOfClass:[revelViewCell_iPad class]])
			{
				cell = (revelViewCell_iPad *)currentObject;
			}
		}
	}
	
	// Set up the cell
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	cell.articleName.text = [[stories objectAtIndex: storyIndex] objectForKey: @"title"];
	NSString *storySummary = [[stories objectAtIndex:storyIndex] objectForKey:@"summary"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#038;" withString:@"&"];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];
	storySummary = [storySummary stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
	cell.articleContent.text = storySummary;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	// Navigation logic
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	NSString *storyLink = [[stories objectAtIndex:storyIndex] objectForKey:@"encoded"];
	NSString *storyTitle = [[stories objectAtIndex:storyIndex] objectForKey:@"title"];	
	
	appDelegate.content = storyLink;
	appDelegate.Title = storyTitle;
	
	NSLog(@"CONTENT CHOSEN: %@", appDelegate.content);
	
	if (self.detailViewController == nil) {
		DetailViewController_iPad *detailView = [[DetailViewController_iPad alloc] initWithNibName:@"DetailViewController_iPad" bundle:[NSBundle mainBundle]];
		self.detailViewController = detailView;
		[detailView release];
		NSLog(@"detailView retainCount:%d",[detailView retainCount]);
	}
	
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = detailViewController.view; 
	
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



#pragma mark XML PARSING METHODS


- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	loading.hidden = NO;
	activityIndicator.hidden = NO;
	[activityIndicator startAnimating];
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
	NSLog(@"rssParser retainCount:%d",[rssParser retainCount]);
	[rssParser release];
	NSLog(@"rssParser after release retainCount:%d",[rssParser retainCount]);
	rssParser = nil;
	[rssParser release];
	NSLog(@"rssParser after second release retainCount:%d",[rssParser retainCount]);
	
	NSLog(@"stories retainCount:%d",[stories retainCount]);
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
	//NSLog(@"errorAlert retainCount:%d",[errorAlert retainCount]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
	// NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
		currentContent = [[NSMutableString alloc] init];
	}
	//NSLog(@"currentElement retainCount:%d", [currentElement retainCount]);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		[item setObject:currentContent forKey:@"encoded"];
		
		//[stories addObject:[[item copy]autorelease]];
		[stories addObject:item];
		item = nil;
		[item release];
		NSLog(@"item retainCount:%d",[item retainCount]);
		//NSLog(@"adding story: %@", currentTitle);
		//NSLog(@"adding summary: %@", currentSummary);
		//NSLog(@"adding link: %@", currentLink);
		//NSLog(@"adding date: %@", currentDate);
		//NSLog(@"adding content: %@", currentContent);
		//[stories release];
		NSLog(@"stories retainCount:%d",[stories retainCount]);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	} else if ([currentElement isEqualToString:@"encoded"]) {
		[currentContent appendString:string];
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	//NSLog(@"all done!");
	//NSLog(@"stories array has %d items", [stories count]);
	
	[revelView reloadData];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	loading.hidden = YES;
	activityIndicator.hidden = YES;
	[activityIndicator stopAnimating];
	
	currentTitle = nil;
	currentDate = nil;
	currentSummary = nil;
	currentLink = nil;
	currentContent = nil;
	currentElement = nil;
	item = nil;
	//rssParser = nil;
	[currentTitle release];
	NSLog(@"currentTitle retainCound:%d", [currentTitle retainCount]);
	[currentDate release];
	NSLog(@"currentDate retainCound:%d", [currentDate retainCount]);
	[currentSummary release];
	NSLog(@"currentSummary retainCound:%d", [currentSummary retainCount]);
	[currentLink release];
	NSLog(@"currentLink retainCound:%d", [currentLink retainCount]);
	[currentContent release];
	NSLog(@"currentContent retainCound:%d", [currentContent retainCount]);
	[currentElement release];
	NSLog(@"currentElement retainCount:%d", [currentElement retainCount]);
	
	[item release];
	NSLog(@"item retainCound:%d", [item retainCount]);
	//[rssParser release];
	
}



#pragma mark BUTTON METHODS

- (IBAction)menuButtonPressed:(id)sender {
	NSLog(@"MENU BUTTON PRESSED");
	
	if (self.mainViewController == nil) {
		MainViewController_iPad *subView = [[MainViewController_iPad alloc] initWithNibName:@"MainViewController_iPad" bundle:[NSBundle mainBundle]];
		self.mainViewController = subView;
		[subView release];
		NSLog(@"subView retainCount:%d",[subView retainCount]);
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

- (IBAction)twitterButtonPressed:(id)sender {
	NSLog(@"twitter");
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/revelandriot"]];
}
- (IBAction)facebookButtonPressed:(id)sender {
	NSLog(@"facebook");
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/pages/Revel-and-Riot/161919083836127"]];
}


- (IBAction) revelButtonPressed:(id)sender {
	NSLog(@"revelButtonPressed");
	
	riotButton.hidden = NO;
	revelButton.hidden = YES;
	tableBackground.image = [UIImage imageNamed:@"tablebackground_revel.jpg"];
	NSString *path = @"http://revelandriot.com/tag/revel/feed";
	[self parseXMLFileAtURL:path];
	[revelView reloadData];
	appDelegate.revelOn = YES;
	NSLog(@"RevelOn = %d",appDelegate.revelOn);
	 
}

- (IBAction) riotButtonPressed:(id)sender {
	NSLog(@"riotButtonPressed");
	
	riotButton.hidden = YES;
	revelButton.hidden = NO;
	tableBackground.image = [UIImage imageNamed:@"tablebackground_riot.jpg"];
	NSString * path = @"http://revelandriot.com/tag/riot/feed";
	[self parseXMLFileAtURL:path];
	[revelView reloadData];
	appDelegate.revelOn = NO;
	NSLog(@"RevelOn = %d",appDelegate.revelOn);
	 
	
}


#pragma mark viewDidLoad

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	//appDelegate.revelOn = YES;
	loading.hidden = YES;
	activityIndicator.hidden = YES;
	[activityIndicator startAnimating];
	
	appDelegate = (AppDelegate_iPad *)[[UIApplication sharedApplication] delegate];
	//NSLog(@"%@", appDelegate.content);
    [super viewDidLoad];
	NSLog(@"self.view=%@", self.view);
	
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 768, 1004);
	// NSLog(@"self.view=%@", self.view);
	

	if ([stories count] == 0) {
		if (appDelegate.revelOn == YES) {
			NSLog(@"revelOn = %d", appDelegate.revelOn);
			[self performSelector:@selector(revelButtonPressed:) withObject:nil afterDelay:0];
			
		} else {
			NSLog(@"revelOn = %d", appDelegate.revelOn);
			NSString *path = @"http://revelandriot.com/tag/riot/feed";
			tableBackground.image = [UIImage imageNamed:@"tablebackground-riot.jpg"];
			[self parseXMLFileAtURL:path];
		}
		
		
	}
	
	cellSize = CGSizeMake([revelView bounds].size.width, 60);
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
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
	
	rssParser = nil;
	[rssParser release];
	NSLog(@"rssParser dealloc retainCount:%d",[rssParser retainCount]);
	stories = nil;
	[stories release];
	NSLog(@"stories dealloc retainCount:%d",[stories retainCount]);
	
    [super dealloc];
}


@end

