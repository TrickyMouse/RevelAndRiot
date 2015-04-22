//
//  PhotoViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PhotoDetailController.h"

@class MainViewController;
@class AppDelegate_iPhone;
@class PhotoDetailController;

@interface PhotoViewController : UIViewController <NSXMLParserDelegate> {
	AppDelegate_iPhone *appDelegate;
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

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) PhotoDetailController *photoDetailController;
@property (nonatomic, retain) AppDelegate_iPhone *appDelegate;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)merchandisePressed:(id)sender;
- (IBAction)loadMerchPhoto:(id)sender;
- (IBAction)mannequeersPressed:(id)sender;
- (IBAction)loadMannePhoto:(id)sender;
- (IBAction)LGBTQPressed:(id)sender;
- (IBAction)loadLGBTQPhoto:(id)sender;

@end
