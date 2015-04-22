//
//  PhotoDetailController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController_iPad.h"

@class PhotoViewController_iPad;
@class AppDelegate_iPad;


@interface PhotoDetailController_iPad : UIViewController {
	AppDelegate_iPad *appDelegate;
	IBOutlet UIWebView *webView;
	IBOutlet UIButton *menuButton;
	IBOutlet UIButton *closeButton;
	IBOutlet UIButton *imageBackgroundButton;
	IBOutlet UIImageView *imageView;
	IBOutlet UIImageView *xImage;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;
	
}

@property (nonatomic, retain) AppDelegate_iPad *appDelegate;
@property (nonatomic, retain) PhotoViewController_iPad *photoViewController;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction) closeButton:(id)sender;


@end

