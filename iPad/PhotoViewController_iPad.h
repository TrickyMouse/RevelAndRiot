//
//  PhotoViewController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController_iPad.h"
#import "PhotoDetailController_iPad.h"

@class MainViewController_iPad;
@class AppDelegate_iPad;
@class PhotoDetailController_iPad;

@interface PhotoViewController_iPad : UIViewController <NSXMLParserDelegate> {
	
	AppDelegate_iPad *appDelegate;
	IBOutlet UIButton *menuButton;
	IBOutlet UIButton *merchandise;
	IBOutlet UIButton *mannequeers;
	IBOutlet UIButton *LGBTQ;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;
	CGSize cellSize;
	NSXMLParser *rssParser;
	NSMutableArray *stories;
	
	NSMutableDictionary * item;
	
	NSString *currentElement;
	NSMutableString *currentTitle, *currentLink, *currentThumb;
	
}

@property (nonatomic, retain) MainViewController_iPad *mainViewController;
@property (nonatomic, retain) PhotoDetailController_iPad *photoDetailController;
@property (nonatomic, retain) AppDelegate_iPad *appDelegate;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)merchandisePressed:(id)sender;
- (IBAction)loadMerchPhoto:(id)sender;
- (IBAction)mannequeersPressed:(id)sender;
- (IBAction)loadMannePhoto:(id)sender;
- (IBAction)LGBTQPressed:(id)sender;
- (IBAction)loadLGBTQPhoto:(id)sender;

@end
