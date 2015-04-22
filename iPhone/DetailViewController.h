//
//  DetailViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate_iPhone;
@class NewsViewController;

@interface DetailViewController : UIViewController <UIWebViewDelegate>{
	
	NewsViewController *newsViewController;
	IBOutlet UIButton *backButton;

}

@property (nonatomic, retain) NSString *contentString;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) IBOutlet UIWebView *contentView;
@property (nonatomic, retain) NewsViewController *newsViewController;

- (IBAction) backButtonPressed:(id)sender;

@end
