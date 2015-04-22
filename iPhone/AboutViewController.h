//
//  AboutViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;
@class AppDelegate_iPhone;


@interface AboutViewController : UIViewController <NSXMLParserDelegate, UIWebViewDelegate> {
	AppDelegate_iPhone *appDelegate;
	
	IBOutlet UIButton *menuButton;
	IBOutlet UIWebView *webView;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;

}

@property (nonatomic, retain) AppDelegate_iPhone *appDelegate;
@property (nonatomic, retain) MainViewController *mainViewController;

- (IBAction)menuButtonPressed:(id)sender;

@end
