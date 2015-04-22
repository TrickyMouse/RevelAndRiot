//
//  DetailViewController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate_iPad;
@class NewsViewController_iPad;

@interface DetailViewController_iPad : UIViewController {
	NewsViewController_iPad *newsViewController;
	IBOutlet UIButton *backButton;
	
}

@property (nonatomic, retain) NSString *contentString;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) IBOutlet UIWebView *contentView;
@property (nonatomic, retain) NewsViewController_iPad *newsViewController;

- (IBAction) backButtonPressed:(id)sender;

@end