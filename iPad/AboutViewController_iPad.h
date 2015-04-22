//
//  AboutViewController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController_iPad.h"

@class MainViewController_iPad;
@class AppDelegate_iPad;


@interface AboutViewController_iPad : UIViewController <NSXMLParserDelegate, UIWebViewDelegate> {

	AppDelegate_iPad *appDelegate;
	
	IBOutlet UIButton *menuButton;
	IBOutlet UIWebView *webView;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;
	
}

@property (nonatomic, retain) AppDelegate_iPad *appDelegate;
@property (nonatomic, retain) MainViewController_iPad *mainViewController;

- (IBAction)menuButtonPressed:(id)sender;

@end
