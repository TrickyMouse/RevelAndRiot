//
//  NewsViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "revelViewCell.h"

@class MainViewController;
@class AppDelegate_iPhone;
@class DetailViewController;

@interface NewsViewController : UIViewController <NSXMLParserDelegate, UITableViewDelegate> {
	AppDelegate_iPhone *appDelegate;
	DetailViewController *detailViewController;
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

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) DetailViewController *detailViewController;
@property (nonatomic, retain) AppDelegate_iPhone *appDelegate;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)revelButtonPressed:(id)sender;
- (IBAction)riotButtonPressed:(id)sender;



@end
