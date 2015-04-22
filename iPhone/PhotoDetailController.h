//
//  PhotoDetailController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"

@class PhotoViewController;
@class AppDelegate_iPhone;


@interface PhotoDetailController : UIViewController <UIWebViewDelegate> {
	AppDelegate_iPhone *appDelegate;
	IBOutlet UIWebView *webView;
	IBOutlet UIButton *menuButton;
	IBOutlet UIButton *closeButton;
	IBOutlet UIButton *imageBackgroundButton;
	IBOutlet UIImageView *imageView;
	IBOutlet UIImageView *xImage;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *loading;

}

@property (nonatomic, retain) AppDelegate_iPhone *appDelegate;
@property (nonatomic, retain) PhotoViewController *photoViewController;

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction) closeButton:(id)sender;


@end
