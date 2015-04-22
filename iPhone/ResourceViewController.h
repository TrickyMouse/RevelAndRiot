//
//  ResourceViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;


@interface ResourceViewController : UIViewController <UIWebViewDelegate> {
	
	IBOutlet UIButton *menuButton;
	IBOutlet UIWebView *webView;
	
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;

}

@property (nonatomic, retain) MainViewController *mainViewController;

- (IBAction)menuButtonPressed:(id)sender;

@end
