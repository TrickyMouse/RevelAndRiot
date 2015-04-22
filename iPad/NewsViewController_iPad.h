//
//  NewsViewController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController_iPad.h"
#import "revelViewCell_iPad.h"

@class MainViewController_iPad;
@class AppDelegate_iPad;
@class DetailViewController_iPad;

@interface NewsViewController_iPad : UIViewController <NSXMLParserDelegate, UITableViewDelegate> {

	AppDelegate_iPad *appDelegate;
	DetailViewController_iPad *detailViewController;
	IBOutlet UITableView *revelView;
	IBOutlet UIButton *menuButton;
	IBOutlet UIButton *twitterButton;
	IBOutlet UIButton *facebookButton;
	IBOutlet UIButton *revelButton;
	IBOutlet UIButton *riotButton;
	IBOutlet UIImageView *tableBackground;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;
	CGSize cellSize;
	NSXMLParser *rssParser;
	NSMutableArray *stories;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString *currentElement;
	NSMutableString *currentTitle, *currentDate, *currentSummary, *currentLink, *currentContent;
	
}

@property (nonatomic, retain) MainViewController_iPad *mainViewController;
@property (nonatomic, retain) DetailViewController_iPad *detailViewController;
@property (nonatomic, retain) AppDelegate_iPad *appDelegate;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)revelButtonPressed:(id)sender;
- (IBAction)riotButtonPressed:(id)sender;



@end
