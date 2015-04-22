//
//  AppDelegate_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController_iPad;

@interface AppDelegate_iPad : NSObject <UIApplicationDelegate, NSXMLParserDelegate> {
    UIWindow *window;
	MainViewController_iPad *mainViewController;
	//NSString *content;
	//NSString *Title;
	
	//NSXMLParser *rssParser;
	//NSMutableArray *stories;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	//NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	//NSString *currentElement;
	//NSMutableString *currentTitle, *currentDate, *currentSummary, *currentLink, *currentContent;
	
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic) BOOL revelOn;
@property (nonatomic) BOOL merchPhotosDownloaded;
@property (nonatomic) BOOL mannequeerPhotosDownloaded;
@property (nonatomic) BOOL LGBTQPhotosDownloaded;
@property (nonatomic, retain) MainViewController_iPad *mainViewController;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSString *html;
@property (nonatomic, retain) NSString *merchPhotoHTML;
@property (nonatomic, retain) NSString *mannequeerPhotoHTML;
@property (nonatomic, retain) NSString *LGBTQPhotoHTML;

//@property (nonatomic, retain) NSString *aboutHTML;

@end

